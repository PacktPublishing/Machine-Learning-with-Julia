### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ c9994475-bef9-4557-b774-e20bd99c049d
using DataFrames, Statistics

# ╔═╡ aac765bf-9ccd-4442-beea-38a765c59d0a
using CSV

# ╔═╡ c8633fe3-cdfe-4346-bf2e-dc43c4d7a90c
using Random

# ╔═╡ 22c94091-2278-4f60-a57a-d8b5d419fd37
using BenchmarkTools

# ╔═╡ 6047eebc-cc01-48e3-8d58-d7c2bb683389
import Downloads

# ╔═╡ ceb84193-d5b6-493c-b109-9bb040dba50c
#=

DataFrame constructor

A DataFrame object can be created with several columns, NamedTuple, Dicts, Arrays, Vectors, Arrays of Strings, matrices, etc.

=#

# ╔═╡ a5853228-b040-46e2-937b-134aa833b199
DataFrame((a=[7, 7], b=[3, 4]))

# ╔═╡ 88224c4a-2e92-48be-a329-9a7e5b449d57
DataFrame([7 1 5; 9 10 11], :auto) # here columns x1, x2, x3, .. are auto generated

# ╔═╡ 386f80f7-10d1-4075-897d-af48ff2f5eda
# There are 3 ways to read CSV files to a DataFrame

# ╔═╡ 46871146-e192-4d1a-944b-eb06fa3d44ec
# Let's download the CSV file

# ╔═╡ f24fb0a1-2a39-4a0d-aa7c-f60856307f6d
Downloads.download("https://www.stats.govt.nz/assets/Uploads/Gross-domestic-product/Gross-domestic-product-March-2021-quarter/Download-data/gross-domestic-product-March-2021-quarter-csv.csv", "gdp.csv")

# ╔═╡ 20e1013b-f753-4e21-a0f6-5afa50341811
# Pass to constructor

# ╔═╡ 92083de8-cb06-48c8-bca3-14a84c80587f
df1 = DataFrame(CSV.File("gdp.csv"))

# ╔═╡ 9a12e206-a900-40e1-ad28-348dfba3b840
# Pipe it

# ╔═╡ 286dff3d-d926-43b2-abcd-0c9c68fb978c
df2 = CSV.File("gdp.csv") |> DataFrame

# ╔═╡ 50e83a4f-68c6-45ff-bc58-fb24a1fdda83
# using the CSV read() function

# ╔═╡ b5352a9f-385f-4e1a-9bd4-c43a95681b9e
df3 = CSV.read("gdp.csv", DataFrame) # Here DataFrame is passed as an object

# ╔═╡ f4b36082-c332-481c-96ba-dcbbd014cc80
gdp = copy(df3)

# ╔═╡ f5d6e9e3-d260-4778-b19c-2d345c06d1e6
# iterate over the dataframe 
eachcol(gdp)

# ╔═╡ 70474af2-007d-4a11-b7ce-d102916875b5
# Accessing columns of DataFrame

# ╔═╡ 7e6cee35-cc6c-43bf-bb02-3584f4148bec
# Using . or ! operators

# ╔═╡ 7699de43-d5ca-42c2-b082-3a49e183152d
gdp.Period # or gdp."Period" gives the same result. You have to make a copy of the DataFrame before accessing columns using '.' (dot operator) or '!' operator.

# ╔═╡ f6d08f22-de4e-4a69-86f2-414445b980b2
gdp[!, :Period]

# ╔═╡ d15d313c-8a75-42aa-918e-4d9cfb15509f
gdp[!, "Period"]

# ╔═╡ ff293953-6eef-4fd5-9399-80610c1e719b
# Accessing dataframes with '!' is better as it makes a copy of the dataframe and any alteration made in the respective columns of the copy doesn't affect the actual dataframe.

# ╔═╡ a6ebd155-2252-4059-96cc-7a1c77b14df1
# using names, propertynames function

# ╔═╡ b3d029a5-4dab-42dd-9735-dd63082fb97f
names(gdp) # returns an array of Strings

# ╔═╡ c1f4417a-5940-48f3-84e5-2b7b6721e031
names(gdp, String) # return column names which are of a particular DataType

# ╔═╡ aa9744b3-7a0f-4d26-8da5-933310ae5d3a
propertynames(gdp) # here you can get column names as Symbols

# ╔═╡ 28ea219e-fbf7-477a-b245-95fc7397b256
# Basic info about DataFrame

# ╔═╡ 528af444-1692-433f-9800-763cb1da56d3
empty(gdp) # creates a 0x0 dataframe with similar column names. If you want to clear out the initial datframe then use in place empty!().

# ╔═╡ 764e6a45-fe29-47a8-914a-21c545887c3c
size(gdp)

# ╔═╡ bb22078d-fe42-4f4c-8b0b-0b4cb1f71469
nrow(gdp)

# ╔═╡ bf4cbe82-43c8-4f5b-bffb-9a0e7ffa8d93
ncol(gdp)

# ╔═╡ 3093d613-5109-4051-b8f6-935b842246a6
describe(gdp, cols=4:7)

# ╔═╡ 9ee344ee-e3a0-44c0-9627-6855e942c789
# While using Julia REPL, all the bulk of a dataframe is not shown in the screen. To fit the whole dataframe you can use show(df, allcols=true) or show(df, allrows=true).

show(gdp, allcols=true)

# ╔═╡ 34e7c893-902f-4868-8855-ad83b56b4b8c
show(gdp, allrows=true)

# ╔═╡ 6c7e3124-ea5f-4e58-820a-abaf55fed480
mean(gdp."MAGNTUDE")

# ╔═╡ 009b37eb-f3a0-418b-971c-0bcbe9ef94fb
mapcols(MAGNTUDE -> MAGNTUDE .^ 7, gdp) # other operators are not discussed as String type data doesn't have to do anything with any other operator other than `^`.

# ╔═╡ c2db935d-f49c-4538-acbd-de75399ae932
first(gdp, 5)

# ╔═╡ 2de6853a-9c0b-414f-a3fa-af38bf407a6a
last(gdp, 5)

# ╔═╡ e2bf6f84-a9f1-4dc4-be6a-3280451cc1ae


# ╔═╡ ee03f50a-3def-44aa-b14d-c4b5da7a9a63


# ╔═╡ 72dfa3c2-ec92-4c97-98a7-525964218356


# ╔═╡ 6d699f5b-0ac0-40b9-a601-ec0205131cdd


# ╔═╡ 08c1fbea-ad4f-414d-a942-6445a5fc8f62


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
Downloads = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[compat]
BenchmarkTools = "~1.1.4"
CSV = "~0.8.5"
DataFrames = "~1.2.2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Statistics", "UUIDs"]
git-tree-sha1 = "42ac5e523869a84eac9669eaceed9e4aa0e1587b"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.1.4"

[[CSV]]
deps = ["Dates", "Mmap", "Parsers", "PooledArrays", "SentinelArrays", "Tables", "Unicode"]
git-tree-sha1 = "b83aa3f513be680454437a0eee21001607e5d983"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.8.5"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "727e463cfebd0c7b999bbf3e9e7e16f254b94193"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.34.0"

[[Crayons]]
git-tree-sha1 = "3f71217b538d7aaee0b69ab47d9b7724ca8afa0d"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.0.4"

[[DataAPI]]
git-tree-sha1 = "ee400abb2298bd13bfc3df1c412ed228061a2385"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.7.0"

[[DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Reexport", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "d785f42445b63fc86caa08bb9a9351008be9b765"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.2.2"

[[DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "7d9d316f04214f7efdbb6398d545446e246eff02"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.10"

[[DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[InvertedIndices]]
deps = ["Test"]
git-tree-sha1 = "15732c475062348b0165684ffe28e85ea8396afc"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.0.0"

[[IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "2ca267b08821e86c5ef4376cffed98a46c2cb205"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.1"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "bfd7d8c7fd87f04543810d9cbd3995972236ba1b"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "1.1.2"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "a193d6ad9c45ada72c14b731a318bedd3c2f00cf"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.3.0"

[[PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "0d1245a357cc61c8cd61934c07447aa569ff22e6"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.1.0"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "54f37736d8934a12a200edea2f9206b03bdf3159"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.3.7"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "TableTraits", "Test"]
git-tree-sha1 = "d0c690d37c73aeb5ca063056283fde5585a41710"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.5.0"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╠═c9994475-bef9-4557-b774-e20bd99c049d
# ╠═aac765bf-9ccd-4442-beea-38a765c59d0a
# ╠═6047eebc-cc01-48e3-8d58-d7c2bb683389
# ╠═c8633fe3-cdfe-4346-bf2e-dc43c4d7a90c
# ╠═22c94091-2278-4f60-a57a-d8b5d419fd37
# ╠═ceb84193-d5b6-493c-b109-9bb040dba50c
# ╠═a5853228-b040-46e2-937b-134aa833b199
# ╠═88224c4a-2e92-48be-a329-9a7e5b449d57
# ╠═386f80f7-10d1-4075-897d-af48ff2f5eda
# ╠═46871146-e192-4d1a-944b-eb06fa3d44ec
# ╠═f24fb0a1-2a39-4a0d-aa7c-f60856307f6d
# ╠═20e1013b-f753-4e21-a0f6-5afa50341811
# ╠═92083de8-cb06-48c8-bca3-14a84c80587f
# ╠═9a12e206-a900-40e1-ad28-348dfba3b840
# ╠═286dff3d-d926-43b2-abcd-0c9c68fb978c
# ╠═50e83a4f-68c6-45ff-bc58-fb24a1fdda83
# ╠═b5352a9f-385f-4e1a-9bd4-c43a95681b9e
# ╠═f5d6e9e3-d260-4778-b19c-2d345c06d1e6
# ╠═f4b36082-c332-481c-96ba-dcbbd014cc80
# ╠═70474af2-007d-4a11-b7ce-d102916875b5
# ╠═7e6cee35-cc6c-43bf-bb02-3584f4148bec
# ╠═7699de43-d5ca-42c2-b082-3a49e183152d
# ╠═f6d08f22-de4e-4a69-86f2-414445b980b2
# ╠═d15d313c-8a75-42aa-918e-4d9cfb15509f
# ╠═ff293953-6eef-4fd5-9399-80610c1e719b
# ╠═a6ebd155-2252-4059-96cc-7a1c77b14df1
# ╠═b3d029a5-4dab-42dd-9735-dd63082fb97f
# ╠═c1f4417a-5940-48f3-84e5-2b7b6721e031
# ╠═aa9744b3-7a0f-4d26-8da5-933310ae5d3a
# ╠═28ea219e-fbf7-477a-b245-95fc7397b256
# ╠═528af444-1692-433f-9800-763cb1da56d3
# ╠═764e6a45-fe29-47a8-914a-21c545887c3c
# ╠═bb22078d-fe42-4f4c-8b0b-0b4cb1f71469
# ╠═bf4cbe82-43c8-4f5b-bffb-9a0e7ffa8d93
# ╠═3093d613-5109-4051-b8f6-935b842246a6
# ╠═9ee344ee-e3a0-44c0-9627-6855e942c789
# ╠═34e7c893-902f-4868-8855-ad83b56b4b8c
# ╠═6c7e3124-ea5f-4e58-820a-abaf55fed480
# ╠═009b37eb-f3a0-418b-971c-0bcbe9ef94fb
# ╠═c2db935d-f49c-4538-acbd-de75399ae932
# ╠═2de6853a-9c0b-414f-a3fa-af38bf407a6a
# ╠═e2bf6f84-a9f1-4dc4-be6a-3280451cc1ae
# ╠═ee03f50a-3def-44aa-b14d-c4b5da7a9a63
# ╠═72dfa3c2-ec92-4c97-98a7-525964218356
# ╠═6d699f5b-0ac0-40b9-a601-ec0205131cdd
# ╠═08c1fbea-ad4f-414d-a942-6445a5fc8f62
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
