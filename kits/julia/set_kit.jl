"""
        set_kit(proj_name, proj_path) 

    Create a folder named `proj_name` in `proj_path`, as well as a Pluto notebook and an internal file structure inside `proj_path/proj_name`.

    File structure and use of the notebook are detailed [here](https://github.com/FellowsFreiesWissen/computational_notebooks).

    See also: [`Pluto`](https://juliapackages.com/p/pluto)

    # Example
    ```julia-repl
     julia> include("set_kit.jl")
     julia> set_kit("example_project", pwd())
    ```
    """
function set_kit(proj_name::String, proj_path::String)
    ## Check project path and whether it is empty
    println(string("Will set project at ", joinpath(proj_path, proj_name)))
    println("Is that correct? Answer yes or no:")
    user_ans = readline()
    if user_ans == "no"
        println("Check help('set_kit') to set up your project's location.")
    else
        if isdir(joinpath(proj_path, proj_name))
            println("There already is a project with this name in this path. Move it or change it's name.")
        else
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
                write(io, "This folder contains the set up for a reproducible workflow as described by https://github.com/FellowsFreiesWissen/computational_notebooks.git\n")
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
                write(io, "|   |   |-- process\n")
                write(io, "|   |   |-- metadata\n")
                write(io, "|   |-- scripts\n")
                write(io, "|-- text\n")
                write(io, "|   |-- README.txt\n")
                write(io, "|   |-- main.doc\n")
                write(io, "|   |-- figures\n")
                write(io, "|   |-- tables\n")
                write(io, "|   |-- supplementary\n")
                write(io, "|   |-- references\n")
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
                write(io, "`data/process`: these are files generated by processing the raw data and these are the ones used in the analysis. It can be a copy of the raw data if that is already ready to use. Any processing of the raw data to generate the files here should be documented in the notebook.")
                write(io, "\n")
                write(io, "`data/metadata`: files containing information about the data that will be useful for future users, readers, and reviewers of your data (e.g. description of variables names, units, and values)")
                write(io, "`scripts`: all code used to process the data, and which, for some reason or another is not included in the notebook because they too cumbersome or not of upmost relevancy for comprehension.")
            end
            
            ### text folder
            touch(joinpath(proj_path, proj_name, "text/README.txt"))
            open(joinpath(proj_path, proj_name, "text/README.txt"), "w") do io
                write(io, "This folder contains the main text of the manuscript, folders containing the figures and tables (unformatted) to be included in it, as well as a folder with the supplementary material and one with references.")
            end
            
            ### submission folder
            touch(joinpath(proj_path, proj_name, "submission/README.txt"))
            open(joinpath(proj_path, proj_name, "submission/README.txt"), "w") do io
                write(io, "This folder contains the files specific to journal submissions, e.g. cover letters, submitted versions.")
            end
            
            ## Create the minimal notebook
            touch(joinpath(proj_path, proj_name, string(proj_name, ".jl")))
            open(joinpath(proj_path, proj_name, string(proj_name, ".jl")), "w") do io
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
                write(io, "# ╔═╡ dfdfa33f-53c1-45e2-8727-86ac01a09398")
                write(io, "\n")
                write(io, "md\"\"\"")
                write(io, "\n\n")
                write(io, "## Brief intro to Pluto notebooks and Markdown syntax") 
                write(io, "\n\n")
                write(io, "Feel free to skip this tutorial if you already know how Pluto noteboos work. Also, make sure to delete it once you submit/share your notebook.")
                write(io, "\n\n")
                write(io, "This is your notebook. When filling it, you should obey Pluto's own syntax to create cells containing code or text.")
                write(io, "\n\n")
                write(io, "To write one single line of narrative text, use simple quotes and include \"md\" before the quotes (as done for the title header above). To write several lines of text, use three pairs of quotes, as in this cell.")
                write(io, "\n\n")
                write(io, "Text written with no special markings will appear without any special formatting when you generate a `.html` or `.pdf` version of this file (click the \"Export\" button above to convert it).")
                write(io, "\n\n")
                write(io, "It is possible to include code inside Markdown cells (it is not executed, though):")
                write(io, "\n\n")
                write(io, "- either as `inline code`")
                write(io, "\n\n")
                write(io, "- or as a block of code:")
                write(io, "\n\n")
                write(io, "```{julia}")
                write(io, "\n")
                write(io, "print(\"This is an example of a code block...\")")
                write(io, "\n")
                write(io, "print(\"for several lines of code\")")
                write(io, "\n")
                write(io, "```")
                write(io, "\n\n")
                write(io, "It is also possible to include hyperlinks: for example, this [link to further details on the Markdown syntax used in Pluto notebooks](https://www.juliapackages.com/p/pluto).")
                write(io, "\n\n")
                write(io, "Cells for code do not need any special marking, unless the cell contains several lines of text. In that case, the code should be included inside a `begin ... end` block.")
                write(io, "\n\n")
                write(io, "```{julia}")
                write(io, "\n")
                write(io, "begin")
                write(io, "\n")
                write(io, "    # your lines")
                write(io, "\n")
                write(io, "    # of code")
                write(io, "\n")
                write(io, "end")
                write(io, "\n")
                write(io, "```")
                write(io, "\n\n")
                write(io, "To execute the code in code cell and have it's results appear above it, click the \"play\" (\"Run cell\") button below the cells or place your cursor inside the chunk and press `Shift+Enter`.")
                write(io, "\n\n")
                write(io, "The outputs of a cell are always show, unless the cell is disabled (available in the `...` - \"Actions\" - button on top of the cell). To hide the contents of the cell itself, click the eye icon on top of the cell.")
                write(io, "\n")
                write(io, "\"\"\"")
                write(io, "\n\n")
                write(io, "# ╔═╡ 37c7bffc-cf46-11eb-19b8-4175e38e818b")
                write(io, "\n")
                write(io, "begin")
                write(io, "\n")
                write(io, "# We suggest having a chunk dedicated to variables containing the paths to the folders related to the project.")
                write(io, "\n")
                write(io, "# The code in this chunk is not relevant for the reader, and thus is not included in the knitted version (therefore, `include = FALSE`).")
                write(io, "\n")
                write(io, "# This is also useful if you are not using the folder structure suggested by this kit, and want to preserve your privacy.")
                write(io, "\n")
                write(io, "# Feel free to edit these paths to adapt them to your needs or not use this suggestion at all.")
                write(io, "\n\n")
                write(io, "\tdata_dir = joinpath(\"results\", \"process\")  ## Do NOT play with stuff in data/raw. That is your back-up. Work only on `process`.")
                write(io, "\n")
                write(io, "\tscripts_dir = joinpath(\"results\", \"scripts\")")
                write(io, "\n")
                write(io, "\tsuppl_dir = joinpath(\"results\", \"supplementary\")")
                write(io, "\n")
                write(io, "\tprocess_dir = joinpath(\"results\", \"process\")")
                write(io, "\n")
                write(io, "\tfigs_dir = joinpath(\"text\", \"figures\")")
                write(io, "\n")
                write(io, "\ttabs_dir = joinpath(\"text\", \"tables\")")
                write(io, "\n")
                write(io, "end")
                write(io, "\n\n")
                write(io, "# ╔═╡ f5062ac5-18e0-42fd-8bb7-1602a8298779")
                write(io, "\n")
                write(io, "md\"## Load data\"")
                write(io, "\n\n")
                write(io, "# ╔═╡ d4465a06-7d32-11ec-3907-59e1f4d60e2f")
                write(io, "\n")
                write(io, "# Here, you write the code to read the data from data_dir")
                write(io, "\n\n")   
                write(io, "# ╔═╡ 6d256dbe-edc9-4132-aac7-62a473601034")
                write(io, "\n")
                write(io, "md\"\"\"")
                write(io, "\n")
                write(io, "## Data analysis")
                write(io, "\n\n")
                write(io, "### Figure 1")
                write(io, "\n")
                write(io, "\"\"\"")
                write(io, "\n\n")
                write(io, "# ╔═╡ f12401f7-1c08-4800-a64d-88f91f6b59fe")
                write(io, "\n")
                write(io, "# Here, you write the code to create a graph (Figure 1) included in the main text.")
                write(io, "\n")
                write(io, "# To avoid the repetition of having the same figure here as in the text, include a line that saves the figure in the figures directory.")
                write(io, "\n\n")
                write(io, "# ╔═╡ 2af762fe-0173-47eb-98d7-8fa6d3b555d3")
                write(io, "\n")
                write(io, "md\"### Figure S1\"")
                write(io, "\n\n")
                write(io, "# ╔═╡ 93c7698d-6e5b-4803-b7c6-90d4da7cd9bf")
                write(io, "\n")
                write(io, "# your code to plot Figure S1")
                write(io, "\n\n")
                write(io, "# ╔═╡ Cell order:")
                write(io, "\n")
                write(io, "# ╠═307335ba-cf46-11eb-28b0-f199cf048ae6")
                write(io, "\n")
                write(io, "# ╠═dfdfa33f-53c1-45e2-8727-86ac01a09398")
                write(io, "\n")
                write(io, "# ╠═37c7bffc-cf46-11eb-19b8-4175e38e818b")
                write(io, "\n")
                write(io, "# ╠═f5062ac5-18e0-42fd-8bb7-1602a8298779")
                write(io, "\n")
                write(io, "# ╠═d4465a06-7d32-11ec-3907-59e1f4d60e2f")
                write(io, "\n")
                write(io, "# ╠═6d256dbe-edc9-4132-aac7-62a473601034")
                write(io, "\n")
                write(io, "# ╠═f12401f7-1c08-4800-a64d-88f91f6b59fe")
                write(io, "\n")
                write(io, "# ╠═2af762fe-0173-47eb-98d7-8fa6d3b555d3")
                write(io, "\n")
                write(io, "# ╠═93c7698d-6e5b-4803-b7c6-90d4da7cd9bf")

                println("Your project is ready to go")
            end
        end
    end
end
