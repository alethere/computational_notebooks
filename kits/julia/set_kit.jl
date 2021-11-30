"""
    set_kit(proj_name, proj_path) 

Create a folder named `proj_name` in `proj_path`, as well as a Pluto notebook and an internal file structure inside `proj_path/proj_name`.

File structure and use of the notebook are detailed [here](https://github.com/ludmillafigueiredo/computational_notebooks).

See also: [`Pluto`](https://juliapackages.com/p/pluto)

# Example
```julia-repl
 julia> include("set_kit.jl")
 julia> set_kit("example_project", pwd())
```
"""
function set_kit(proj_name::String = "project", proj_path::String = pwd())
    println(string("Will set project at ", joinpath(proj_path, proj_name)))
    println("Is that correct? Answer yes or no:")
    user_ans = readLine()
    if user_ans == "no"
        error("Check help('set_kit') to set up your project's location.")
    end
    ## Create project in path
    cd(proj_path)
    ## Create file structure
    ### first level
    mkdir(proj_name)
    ### main folders of a project
    map(mkdir, map(x -> joinpath(proj_name, x),
                   ["results","text", "submission"]))
    ### main folders of results
    map(mkdir, map(x -> joinpath(joinpath(proj_name,"results"), x),
                   ["data", "scripts"]))
    map(mkdir, map(x -> joinpath(joinpath(proj_name,"results", "data"), x),
                   ["raw", "processed"]))
    ### main folders of text
    map(mkdir, map(x -> joinpath(joinpath(proj_name,"text"), x),
                   ["figures","tables", "supplementary"]))

    ### main folder
    touch(joinpath(proj_path, proj_name, "README.txt"))
    open(joinpath(proj_path, proj_name, "README.txt"), "w") do io 
        write(io, "This folder contains the set up for a reproducible workflow as described by https://github.com/ludmillafigueiredo/computational_notebooks.git\n")
        write(io, "\n")
        write(io, "The file structure is organized as such:\n")
        write(io, "\n")  
        write(io, "projet_name\n")
        write(io, "|-- README.txt\n")
        write(io, "|-- main.Rmd\n")
        write(io, "|-- results\n")
        write(io, "|   |-- README.txt\n")
        write(io, "|   |-- data\n")
        write(io, "|   |   |-- raw\n")
        write(io, "|   |   |-- processed\n")
        write(io, "|   |-- scripts\n")
        write(io, "|-- text\n")
        write(io, "|   |-- README.txt\n")
        write(io, "|   |-- main.doc\n")
        write(io, "|   |-- figures\n")
        write(io, "|   |-- tables\n")
        write(io, "|   |-- supplementary\n")
        write(io, "|-- submission\n")
        write(io, "|   |-- README.txt\n")
        write(io, "|   |-- journal1\n")
        write(io, "|       |-- first\n")
        write(io, "|   |-- journal2\n")
        write(io, "|       |-- first\n")
        write(io, "|       |-- revisions\n")
    end
    
    ### results folder
    touch(joinpath(proj_path, proj_name, "results/README.txt"))
    open(joinpath(proj_path, proj_name, "results/README.txt"), "w") do io
        write(io, "This folder contains all files of results or their processing, organized in the following subfolders:")
        write(io, "\n")
        write(io, "`data/raw`: your raw data files. These should not be protected against any change after the first storage")
        write(io, "\n")
        write(io, "`data/processed`: these are files generated by processing the raw data and these are the ones used in the analysis. It can be a copy of the raw data if that is already ready to use. Any processing of the raw data to generate the files here should be documented in the notebook.")
        write(io, "\n")
        write(io, "`scripts`: all code used to process the data, and which, for some reason or another is not included in the notebook because they too cumbersome or not of upmost relevancy for comprehension.")
    end
    
    ### text folder
    touch(joinpath(proj_path, proj_name, "text/README.txt"))
    open(joinpath(proj_path, proj_name, "text/README.txt"), "w") do io
        write(io, "This folder contains the main text of the manuscript, folders containing the figures and tables (unformatted) to be included in it, as well as a folder with the supplementary material.")
    end
    
    ### submission folder
    touch(joinpath(proj_path, proj_name, "submission/README.txt"))
    open(joinpath(proj_path, proj_name, "submission/README.txt"), "w") do io
        write(io, "This folder contains the files specific to journal submissions, e.g. cover letters, submitted versions.")
    end
    
    ## Create the minimal notebook
    touch(joinpath(proj_path, string(proj_name, ".jl")))
    open(joinpath(proj_path, string(proj_name, ".jl")), "w") do io
        write(io, "### A Pluto.jl notebook ###")
        write(io, "\n\n")
        write(io, "using Markdown")
        write(io, "\n")
        write(io, "using InteractiveUtils")
        write(io, "\n\n")
        write(io, "# ╔═╡ 307335ba-cf46-11eb-28b0-f199cf048ae6")
        write(io, "\n")
        write(io, "md\" ## Your title here\"")
        write(io, "\n\n")
        write(io, "# ╔═╡ 37c7bffc-cf46-11eb-19b8-4175e38e818b")
        write(io, "\n")      
        write(io, "## Paths for easy call from the Pluto notebook")
        write(io, "\n")
        write(io, "begin")
        write(io, "\n")
        write(io, "\tdata_dir = joinpath(\"results\", \"clean_data\") ## do NOT play with stuff in raw_data. That is your back-up")
        write(io, "\n")
        write(io, "\tscripts_dir = joinpath(\"results\", \"scripts\")")
        write(io, "\n")
        write(io, "\tsuppl_dir = joinpath(\"results\", \"supplementary\")")
        write(io, "\n")
        write(io, "\tsemiprods_dir = joinpath(\"results\", \"semi_products\")")
        write(io, "\n")
        write(io, "\tfigures_dir = joinpath(\"text\", \"figures\")")
        write(io, "\n")
        write(io, "\ttables_dir = joinpath(\"text\", \"tables\")")
        write(io, "\n")
        write(io, "end")
        write(io, "\n\n\n")
        write(io, "# ╔═╡ Cell order:")
        write(io, "\n")
        write(io, "# ╠═307335ba-cf46-11eb-28b0-f199cf048ae6")
        write(io, "\n")
        write(io, "# ╠═37c7bffc-cf46-11eb-19b8-4175e38e818b")
    end
end
