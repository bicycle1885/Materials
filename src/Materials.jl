module Materials

export material, @material

import TOML

"""
    material(pkgname, name)

Find and return a material `name` from `pkgname`.
"""
function material(pkgname, name)
    return load_material(string(pkgname), Symbol(name)).value
end

"""
    @material pkgname names...

Load materials `names` from `pkgname` into the current scope.
"""
macro material(pkgname, names...)
    vals = Expr[]
    for name in names
        m = load_material(string(pkgname), name)
        push!(vals, :($(m.name) = $(m.value); @doc $(m.description) $(m.name)))
        info("load $(m.name) as $(summary(m.value))")
    end
    esc(quote
        $(vals...)
        nothing
    end)
end

"""
    materialize(pkgname)

Build materials of `pkgname`.
"""
function materialize(pkgname)
    index, dir = load_index(string(pkgname))
    cd(dir) do
        for material in index["materials"]
            name = material["name"]
            info("materializing $(name)")
            if haskey(material, "build")
                build = material["build"]
                run(`julia -e $(build)`)
            end
        end
    end
end

struct Material
    name::Symbol
    description::String
    value::Any
end

function load_material(pkgname, name::Symbol)::Material
    index, dir = load_index(pkgname)
    cd(dir) do
        for material in index["materials"]
            if material["name"] != String(name)
                continue
            end
            description = material["description"]
            action = get(material, "action", "filepath")
            if action isa AbstractString
                action = [action]
            end
            action = first(action)
            if action == "filepath"
                return Material(name, description, joinpath(dir, material["filename"]))
            elseif action == "deserialize"
                return Material(name, description, open(deserialize, material["filename"]))
            else
                throw(ArgumentError("unknown action: '$(action)'"))
            end
        end
        throw(ArgumentError("cannot find material named '$(name)'"))
    end
end

function load_index(pkgname)
    dir = Pkg.dir(pkgname, "materials")
    if !isdir(dir)
        throw(ArgumentError("package $(pkgname) does not have materials"))
    end
    indexfile = joinpath(dir, "index.toml")
    if !isfile(indexfile)
        throw(ArgumentError("index.toml does not exist"))
    end
    return TOML.parsefile(indexfile), dir
end

end # module
