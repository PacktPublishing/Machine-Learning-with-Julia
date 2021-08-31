### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ 6a8d7cf4-08d2-11ec-2bfe-77d314082c71
using StatsModels

# ╔═╡ 5ecccbc3-37db-4326-b363-c15d2c1c55fb
using Random

# ╔═╡ 45ae7bfb-c4cf-425c-9541-a4410f6bbf02
using Tables

# ╔═╡ a68d1c2d-cedd-4fd7-923b-69bf70c91b50
using DataFrames

# ╔═╡ ea2b9175-ebd3-4f33-b2c4-d947651281c7
using GLM

# ╔═╡ 3b93d4d1-9d32-4e6e-a517-87ad8815f071
using StableRNGs

# ╔═╡ b6c4bdd5-378c-4338-8690-d155abe5eda5
Random.seed!(1234)

# ╔═╡ 43502b67-c04e-4d4b-91dd-1b9fec574097
rng = StableRNG(1)

# ╔═╡ 57233fca-dd70-4113-88e7-3699f2987a10
f1 = @formula(y ~ 1 + a + b + c + b&c) # can only allow ints as intercept and also can be of any form such as @formula(y ~ 5 + a - b * c / b|c)

# ╔═╡ 59a1d516-1349-40cf-a63b-ba397c51429c
df = DataFrame(y = rand(rng, 9), a = 1:9, b = rand(rng, 9), c = repeat(["d","e","f"], 3))

# ╔═╡ a0faf1c1-bbb6-4ddb-ae52-9e618b0541e3
f = apply_schema(f1, schema(f1, df))

# ╔═╡ c774b110-cac9-433b-aca8-6e2ae4de7509
resp, pred = modelcols(f, df)

# ╔═╡ 7b823b2d-8152-432b-bed0-8e956b370750
pred

# ╔═╡ de56af73-fb18-4a65-b0bd-10eae75d2861
coefnames(f)

# ╔═╡ d4c50010-b5ff-4e2a-8f7e-7e3638a08d7c
modelmatrix(@formula(y ~ 1 + a + log(1+a)), df)

# ╔═╡ 9de377d7-65bb-4acc-a381-e3ac5641bcc1
lm(@formula(log(y) ~ 1 + a + b), df)

# ╔═╡ 4a115e3e-0393-44f2-965d-5b28ce45844d
# Creating formulae programmatically

# ╔═╡ 77facf95-32cd-46f0-92e7-36d366bbf6e9
Term(:y) ~ ConstantTerm(1) + Term(:a) + Term(:b) + Term(:a) & Term(:b)

# ╔═╡ e1559ad2-81ac-42c9-9773-aa1198bfcd05
ts = term.((5, :a, "b"))

# ╔═╡ 8c2764f2-d3e6-4ccc-8564-5fd70ec79ea6
f2 = term(:y) ~ foldl(+, ts)

# ╔═╡ 6d1f3e8b-f6ad-4b70-9161-3946b4dae736
# Fitting a model from formulae

# ╔═╡ 7ccea56a-9287-44d8-97ea-ca3346273f81
data = DataFrame(a = rand(rng, 100), b = repeat(["w", "x", "y", "z"], 25))

# ╔═╡ 4c78b70c-e582-416d-9601-6d30d82d7819
X = StatsModels.modelmatrix(@formula(y ~ 1 + a*b).rhs, data)

# ╔═╡ 219f7dcc-880e-4dd3-b565-515f7ab76570
data.y = X*(1:8) .+ randn(rng, 100)*0.1 # be careful with the operator sequence

# ╔═╡ a6488e6d-03c5-4353-8a31-d2c1bd461353
mod = fit(LinearModel, @formula(y ~ 1 + a*b), data)

# ╔═╡ 0c37727f-614d-47dc-b820-68adef96e97a
#  Julia's @formula is meant to be extendable as feasible through Julian's usual techniques of multiple dispatch. 

# ╔═╡ e9096f5b-147e-4727-89e2-6ec58d6abcd5
# Modelling categorical data

# ╔═╡ 40a59d50-4507-4e84-a1d1-9df3feeb9d71
#=
StatsModels uses a number of contrast coding techniques to transform category data into a numerical representation appropriate for modelling.
One of the most common contrast-coding systems is mapping a categorical vector with k levels onto a model matrix with k-1 linearly independent rows. 
=#

# ╔═╡ 1fdedb94-6afa-4b1a-836c-c7fbdbf1b762
#=
Some of the most contrast coding techniques implemented in StatsModels are:

1. DummyCoding: Code each non-base level as a 0-1 indicator column

2. EffectsCoding: Code each non-base level as 1, and base as -1

3. HelmertCoding: Code each non-base level as the difference from the mean of the lower levels

4. HypothesisCoding: Manually specify contrasts via a hypothesis matrix, which gives the weighting for the average response for each level

5. SeqDiffCoding:  Code for differences between sequential levels of the variable

6. ContrastsCoding: Manually specify contrasts matrix, which is directly copied into the model matrix

The default coding system is DummyCoding. To change the contrast coding system in the model frame, set `contrasts` argument to the desired coding system.

=#

# ╔═╡ 85c7b430-7d36-4246-829b-4548b131892c
f_def = @formula(y ~ 1 + log(w) + x)

# ╔═╡ 3864f3ed-43a6-4df5-a258-1e5ab2d4f6c2
df_def = DataFrame(y = rand(rng, 8), w = rand(rng, 8), x = repeat(["a", "b"], 4))

# ╔═╡ cac06c6b-dd5f-44cb-b3c7-c6e0c6d2002a
schema(f_def, df_def)

# ╔═╡ be6b2a96-7202-4d24-bd2b-95b3342305ff
f_def1 = apply_schema(f_def, schema(f_def, df_def))

# ╔═╡ 62aa8fd4-ec01-4c7b-94e0-931099fb2438
#=
On the basis of the given contrasts and the ModelFrame data, a new schema is computed, and then applied to the FormulaTerm of the ModelFrame.

Only the ModelFrame is mutated as AbstractTerms are immutable and any changes to Terms will produce a copy.
=#

# ╔═╡ 00bda272-74c8-4f14-a2e3-df87d6e3b873
mf = ModelFrame(f_def, df_def, contrasts = Dict(:x => SeqDiffCoding())) # when constructing ModelFrame

# ╔═╡ c6ce6ae3-5f3a-4608-95f0-e0256ffc2584
setcontrasts!(mf, Dict(:x => EffectsCoding())) # when trying to change the already created ModelFrame

# ╔═╡ 7593f656-c72b-47d2-bda0-8203aab852d6
#=

There's a distinction between HypothesisCoding and StatsModels.
ContrastsCoding and other contrast coding systems. These allow you to set a contrast matrix manually.
Contrast matrices M are used for variables that have more than one level, and transfer those levels onto the columns of a model matrix.
This is the full-rank indicator matrix (X), which is equal to 1 in the case of x[i], and zero in all other cases, based on the fact that levels(x)[j] == levels(x)[i].
Therefore, Y = X * M is the model matrix column created by the contrasts matrix, M.

In the context of categorical data levels, a ContrastsMatrix object represents the instantiation of a contrast coding scheme. 

=#

# ╔═╡ 30fcd878-7e21-458f-af39-40249dea9dd7
#= 
There is a non-zero mean in the columns, and they are orthogonal to each other but collinear with an intercept column (and lower-order columns).
For example, in regression models, the intercept is the mean of the dependant variable at a certain base level when using dummy coding. 

It is similar to One-Hot encoding.
=#

StatsModels.ContrastsMatrix(DummyCoding(), ["a", "c", "d", "f"]).matrix 

# ╔═╡ 3ef9ab8d-b3dd-4de7-a9c5-f1f3affeca13
#=
Model matrix columns centered on the mean are generated when all levels are equally common.
The resulting columns are not orthogonal when there are more than two levels.The intercept is the grand mean of the regression model with an effects-coded argument.

Similar to DummyCoding, but with a base level of -1 instead of 0. 
=#
StatsModels.ContrastsMatrix(EffectsCoding(), ["a", "c", "d", "f"]).matrix

# ╔═╡ ba812640-89f4-4c4c-b978-77f6d082e608
#=
According to Helmert coding, when all levels are equally common, orthogonal columns are generated that are mean-centered. 

In Helmert coding, each level is coded as the difference from the average of the levels below it.
=#
StatsModels.ContrastsMatrix(HelmertCoding(), ["a", "c", "d", "f"]).matrix

# ╔═╡ b444f628-95ee-46dd-938a-aaeddbae964c
#=
In order to test "sequential difference" hypotheses, code each level such that it can be compared to the one below.
nth predictor examines a null hypothesis that the difference between levels n and n+1 is zero in this case. 

=#
seqdiff = StatsModels.ContrastsMatrix(SeqDiffCoding(), ["a", "c", "d", "f"]).matrix

# ╔═╡ 655f9232-c85e-4094-b757-9be7901b4c61
StatsModels.hypothesis_matrix(seqdiff) # this shows a better picture of the corresponding hypothesis matrix

# ╔═╡ 246223cb-df6e-4dcc-b590-f6ec5e08636b
#=
In Full Dummy coding, each level including the base level, has one indication (1 or 0) column. This is exactly One-hot encoding. This is not exported.
=#

StatsModels.ContrastsMatrix(StatsModels.FullDummyCoding(), ["a", "b", "c"]).matrix

# ╔═╡ d4d4e674-4591-41f3-b544-4c6c4bf87fbd
# Temporal Terms

# ╔═╡ b4c15ce5-4f87-4f0a-af83-b45cd7ac9a89
df1 = DataFrame(y=-10:10, x=-20:2:20) # or use ``y, x = term(:y), term(:x)``

# ╔═╡ d419deee-45b4-4910-a6a7-32b9670d41e4
fun = @formula(y ~ x + lag(x, 2) + lead(x, 2))

# ╔═╡ 1546bb8c-e34b-4a8d-89fa-979cb93b5bf9
func = apply_schema(fun, schema(fun, df1))

# ╔═╡ c10e0eac-a057-4a85-8c19-137ee8e26f63
modelmatrix(func, df1)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
GLM = "38e38edf-8417-5370-95a0-9cbb8c7f171a"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
StableRNGs = "860ef19b-820b-49d6-a774-d7a799459cd3"
StatsModels = "3eaba693-59b7-5ba5-a881-562e759f1c8d"
Tables = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"

[compat]
DataFrames = "~1.2.2"
GLM = "~1.5.1"
StableRNGs = "~1.0.0"
StatsModels = "~0.6.24"
Tables = "~1.5.0"
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

[[ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "bdc0937269321858ab2a4f288486cb258b9a0af7"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.3.0"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "727e463cfebd0c7b999bbf3e9e7e16f254b94193"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.34.0"

[[CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

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

[[Distributions]]
deps = ["FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SparseArrays", "SpecialFunctions", "Statistics", "StatsBase", "StatsFuns"]
git-tree-sha1 = "f389cb8974e02d7eaa6ae2ccedbbfb43174cd8e8"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.14"

[[DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "a32185f5428d3986f47c2ab78b1f216d5e6cc96f"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.5"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[FillArrays]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "Statistics"]
git-tree-sha1 = "7c365bdef6380b29cfc5caaf99688cd7489f9b87"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "0.12.2"

[[Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[GLM]]
deps = ["Distributions", "LinearAlgebra", "Printf", "Reexport", "SparseArrays", "SpecialFunctions", "Statistics", "StatsBase", "StatsFuns", "StatsModels"]
git-tree-sha1 = "f564ce4af5e79bb88ff1f4488e64363487674278"
uuid = "38e38edf-8417-5370-95a0-9cbb8c7f171a"
version = "1.5.1"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[InvertedIndices]]
deps = ["Test"]
git-tree-sha1 = "15732c475062348b0165684ffe28e85ea8396afc"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.0.0"

[[IrrationalConstants]]
git-tree-sha1 = "f76424439413893a832026ca355fe273e93bce94"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.0"

[[IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "642a199af8b68253517b80bd3bfd17eb4e84df6e"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.3.0"

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

[[LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "3d682c07e6dd250ed082f883dc88aee7996bf2cc"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.0"

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

[[OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "4dd403333bcf0909341cfe57ec115152f937d7d8"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.1"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "cde4ce9d6f33219465b55162811d8de8139c0414"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.2.1"

[[Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00cfd92944ca9c760982747e9a1d0d5d86ab1e5a"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.2"

[[PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "0d1245a357cc61c8cd61934c07447aa569ff22e6"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.1.0"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "12fbe86da16df6679be7521dfb39fbc861e1dc7b"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.4.1"

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

[[Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "bf3188feca147ce108c76ad82c2792c57abe7b1f"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.7.0"

[[Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "68db32dff12bb6127bac73c209881191bf0efbb7"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.3.0+0"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[ShiftedArrays]]
git-tree-sha1 = "22395afdcf37d6709a5a0766cc4a5ca52cb85ea0"
uuid = "1277b4bf-5013-50f5-be3d-901d8477a67a"
version = "1.0.0"

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

[[SpecialFunctions]]
deps = ["ChainRulesCore", "LogExpFunctions", "OpenSpecFun_jll"]
git-tree-sha1 = "a322a9493e49c5f3a10b50df3aedaf1cdb3244b7"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "1.6.1"

[[StableRNGs]]
deps = ["Random", "Test"]
git-tree-sha1 = "3be7d49667040add7ee151fefaf1f8c04c8c8276"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.0"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[StatsAPI]]
git-tree-sha1 = "1958272568dc176a1d881acb797beb909c785510"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.0.0"

[[StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "8cbbc098554648c84f79a463c9ff0fd277144b6c"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.10"

[[StatsFuns]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "46d7ccc7104860c38b11966dd1f72ff042f382e4"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "0.9.10"

[[StatsModels]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "Printf", "ShiftedArrays", "SparseArrays", "StatsBase", "StatsFuns", "Tables"]
git-tree-sha1 = "a209a68f72601f8aa0d3a7c4e50ba3f67e32e6f8"
uuid = "3eaba693-59b7-5ba5-a881-562e759f1c8d"
version = "0.6.24"

[[SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

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
# ╠═6a8d7cf4-08d2-11ec-2bfe-77d314082c71
# ╠═5ecccbc3-37db-4326-b363-c15d2c1c55fb
# ╠═45ae7bfb-c4cf-425c-9541-a4410f6bbf02
# ╠═a68d1c2d-cedd-4fd7-923b-69bf70c91b50
# ╠═ea2b9175-ebd3-4f33-b2c4-d947651281c7
# ╠═3b93d4d1-9d32-4e6e-a517-87ad8815f071
# ╠═b6c4bdd5-378c-4338-8690-d155abe5eda5
# ╠═43502b67-c04e-4d4b-91dd-1b9fec574097
# ╠═57233fca-dd70-4113-88e7-3699f2987a10
# ╠═59a1d516-1349-40cf-a63b-ba397c51429c
# ╠═a0faf1c1-bbb6-4ddb-ae52-9e618b0541e3
# ╠═c774b110-cac9-433b-aca8-6e2ae4de7509
# ╠═7b823b2d-8152-432b-bed0-8e956b370750
# ╠═de56af73-fb18-4a65-b0bd-10eae75d2861
# ╠═d4c50010-b5ff-4e2a-8f7e-7e3638a08d7c
# ╠═9de377d7-65bb-4acc-a381-e3ac5641bcc1
# ╠═4a115e3e-0393-44f2-965d-5b28ce45844d
# ╠═77facf95-32cd-46f0-92e7-36d366bbf6e9
# ╠═e1559ad2-81ac-42c9-9773-aa1198bfcd05
# ╠═8c2764f2-d3e6-4ccc-8564-5fd70ec79ea6
# ╠═6d1f3e8b-f6ad-4b70-9161-3946b4dae736
# ╠═7ccea56a-9287-44d8-97ea-ca3346273f81
# ╠═4c78b70c-e582-416d-9601-6d30d82d7819
# ╠═219f7dcc-880e-4dd3-b565-515f7ab76570
# ╠═a6488e6d-03c5-4353-8a31-d2c1bd461353
# ╠═0c37727f-614d-47dc-b820-68adef96e97a
# ╠═e9096f5b-147e-4727-89e2-6ec58d6abcd5
# ╠═40a59d50-4507-4e84-a1d1-9df3feeb9d71
# ╠═1fdedb94-6afa-4b1a-836c-c7fbdbf1b762
# ╠═85c7b430-7d36-4246-829b-4548b131892c
# ╠═3864f3ed-43a6-4df5-a258-1e5ab2d4f6c2
# ╠═cac06c6b-dd5f-44cb-b3c7-c6e0c6d2002a
# ╠═be6b2a96-7202-4d24-bd2b-95b3342305ff
# ╠═62aa8fd4-ec01-4c7b-94e0-931099fb2438
# ╠═00bda272-74c8-4f14-a2e3-df87d6e3b873
# ╠═c6ce6ae3-5f3a-4608-95f0-e0256ffc2584
# ╠═7593f656-c72b-47d2-bda0-8203aab852d6
# ╠═30fcd878-7e21-458f-af39-40249dea9dd7
# ╠═3ef9ab8d-b3dd-4de7-a9c5-f1f3affeca13
# ╠═ba812640-89f4-4c4c-b978-77f6d082e608
# ╠═b444f628-95ee-46dd-938a-aaeddbae964c
# ╠═655f9232-c85e-4094-b757-9be7901b4c61
# ╠═246223cb-df6e-4dcc-b590-f6ec5e08636b
# ╠═d4d4e674-4591-41f3-b544-4c6c4bf87fbd
# ╠═b4c15ce5-4f87-4f0a-af83-b45cd7ac9a89
# ╠═d419deee-45b4-4910-a6a7-32b9670d41e4
# ╠═1546bb8c-e34b-4a8d-89fa-979cb93b5bf9
# ╠═c10e0eac-a057-4a85-8c19-137ee8e26f63
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
