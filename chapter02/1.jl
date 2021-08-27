### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ 4ea44e3a-0730-11ec-1592-4dd06da99612
using Statistics

# ╔═╡ b8014e77-3a78-4bae-9dd5-11dc52bb5157
# Julian Statistics
# We will go through some basic functions and their uses from the Statistics package shipped with JuliaLang.

# ╔═╡ fe54d8f2-fe7d-4f81-a5df-dde04fad9a12
mean(30:60) # Intt64 can be used

# ╔═╡ f134f937-d2b6-443f-87fd-aca05b14ed8a
mean(30.5:45.6) #Float64 can be used

# ╔═╡ c259168a-7fc3-4f88-92c5-600ec733b207
mean([1, missing, 3, 4, 5, missing]) #returns missing

# ╔═╡ 60192011-3913-4257-a1f8-38af13f3beab
mean([1, NaN, 3, 4, 5, NaN, 7, 8]) #returns NaN

# ╔═╡ 87c16954-78cd-4b68-b234-9956c5ba374a
# Trivia Q'
# What do you mean will be the output of the following?

mean([1, missing, 3, 4, NaN, 6, 7, 8])#missing takes precedence if both NaN, missing are present

# ╔═╡ f9646321-6cb1-4693-972b-e39347235fe3
mean(skipmissing([1, missing, 3, 4, 5, 6])) #use skipmissing to remove "missing" and get mean of rest of the data

# ╔═╡ b20a6304-8dc5-4cd3-b5dc-87474dd2bb8e
mat = [3 4 6; 5 7 8] # a 2D matrix

# ╔═╡ 4dd9726f-1ce3-488f-a9ef-f52827ee8e0b
mean!([1., 1.], mat) # get mean along the rows

# ╔═╡ a806544f-24d8-49f1-9fa5-3e4465605716
# Trivia Q'
# What do you mean will be the output of the following?

mean!([7., 7.], mat) # this can be any numeric constant

# ╔═╡ 0b949f0a-08f5-4e02-8174-e630dd165156
mean!([1. 1. 1.], mat) # get mean along the columns

# ╔═╡ 3246fbe2-71f2-48e3-b207-1c49e5aa989c
mean(mat, dims=1) # get mean along one dimension

# ╔═╡ a1b703a6-ce76-4b49-9b23-7169acc90ed5
mean(mat, dims=2) # get mean along two dimensions

# ╔═╡ dfe50e29-1b0a-407d-b7b2-eedcb4d810eb
mean(-, [3, 4, 5]) # apply the function to the data, then compute mean

# ╔═╡ 58c1f4ab-6379-44d8-a047-5d2649e36c9a
median([1, 2, 3])

# ╔═╡ 5bf65349-2990-4f14-95eb-71c753bf2a63
median([1, 2, missing, 4])

# ╔═╡ 7ac95528-2672-4e8a-a51e-efc9287a39d9
median(mat, dims=1)

# ╔═╡ 8e251afb-74be-4f2c-a7f7-c4e03f7c29b7
middle(mat)

# ╔═╡ 19579d09-6d78-4236-925c-0fff03185dd4
middle([1.4, 2.76, 3, 4.27])

# ╔═╡ 1d616172-129c-4e4a-ba1b-83bfff25c40c
quantile!([0, 1, 5, 6, 3, 7, 8], 0.5)

# ╔═╡ ea2f09ad-91ab-4e22-a5bb-6f09ec47056e
quantile(0:20, [0.1, 0.3, 0.9, 0.5, 0.7])

# ╔═╡ 40deb75f-7f21-414e-98b0-606c2ad6bf68
quantile(skipmissing([7, 36, missing]), 0.5)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
"""

# ╔═╡ Cell order:
# ╠═b8014e77-3a78-4bae-9dd5-11dc52bb5157
# ╠═4ea44e3a-0730-11ec-1592-4dd06da99612
# ╠═fe54d8f2-fe7d-4f81-a5df-dde04fad9a12
# ╠═f134f937-d2b6-443f-87fd-aca05b14ed8a
# ╠═c259168a-7fc3-4f88-92c5-600ec733b207
# ╠═60192011-3913-4257-a1f8-38af13f3beab
# ╠═87c16954-78cd-4b68-b234-9956c5ba374a
# ╠═f9646321-6cb1-4693-972b-e39347235fe3
# ╠═b20a6304-8dc5-4cd3-b5dc-87474dd2bb8e
# ╠═4dd9726f-1ce3-488f-a9ef-f52827ee8e0b
# ╠═a806544f-24d8-49f1-9fa5-3e4465605716
# ╠═0b949f0a-08f5-4e02-8174-e630dd165156
# ╠═3246fbe2-71f2-48e3-b207-1c49e5aa989c
# ╠═a1b703a6-ce76-4b49-9b23-7169acc90ed5
# ╠═dfe50e29-1b0a-407d-b7b2-eedcb4d810eb
# ╠═58c1f4ab-6379-44d8-a047-5d2649e36c9a
# ╠═5bf65349-2990-4f14-95eb-71c753bf2a63
# ╠═7ac95528-2672-4e8a-a51e-efc9287a39d9
# ╠═8e251afb-74be-4f2c-a7f7-c4e03f7c29b7
# ╠═19579d09-6d78-4236-925c-0fff03185dd4
# ╠═1d616172-129c-4e4a-ba1b-83bfff25c40c
# ╠═ea2f09ad-91ab-4e22-a5bb-6f09ec47056e
# ╠═40deb75f-7f21-414e-98b0-606c2ad6bf68
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
