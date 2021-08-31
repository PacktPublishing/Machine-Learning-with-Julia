### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ d9abc4aa-0761-11ec-1e22-49da8a331b0a
using StatsKit # You can use either StatsKit or StatsBase

# ╔═╡ 01de7df9-40a6-4357-b267-7da5644feb79
using StatsBase

# ╔═╡ 6b54ad19-5586-4513-94e5-705be4d1d71b
using LinearAlgebra

# ╔═╡ 723a49e0-1f31-41cb-bccc-6ab808b2069b
using Distributions

# ╔═╡ 1ad159cb-4294-4093-83cd-6de82cafa626
using Random

# ╔═╡ 1be117b7-17db-41e1-8278-36d63e6ec5c2
using Plots

# ╔═╡ 735f87e9-d631-45a2-94e9-e8a5a2460613
using BenchmarkTools

# ╔═╡ 892d7d9f-3048-48fa-b2c3-2ca11c11b143
Random.seed!(1234)

# ╔═╡ a8c0864a-753f-4426-a4cd-b7fa3a025913
a = AnalyticWeights(rand(3))

# ╔═╡ 268fc9b3-94f4-41b7-b7aa-7e9bd583f330
f = FrequencyWeights(rand(3))

# ╔═╡ 3d56cbe2-5992-4394-968e-9bbe060ced17
w = Weights(rand(3))

# ╔═╡ 0ecd945d-cdb4-415d-898e-ffa5cbe5b421
e = eweights(1:10, 0.3)

# ╔═╡ ae34080f-c20b-4751-97c2-7d2e69459560
# Functions defined for Weight vectors

# ╔═╡ 095aa3c4-b07c-4931-a460-e8faa7ce59c4
eltype(w)

# ╔═╡ baf32851-cfe4-428c-983f-397c7d282e4a
length(w)

# ╔═╡ 666d8931-cfb5-4f82-8f84-c184530040b9
isempty(w)

# ╔═╡ 470916ab-19b2-41c1-963a-d78fe5d4b834
values(a)

# ╔═╡ 458b9ef4-2712-4b50-ad38-a64b87b559ba
sum(f)

# ╔═╡ c01f8d26-8c74-41d9-beca-9cc147981135
mean(w)

# ╔═╡ 82217335-aeff-4fce-af72-345204a9841e
middle(w)

# ╔═╡ 96bac8bf-5b79-49c4-b5a2-555b9c02b96c
median(w)

# ╔═╡ 32358a32-7df9-40ab-a6fb-55af911dfbda
# Mean Functions

# ╔═╡ 02695e86-154b-4359-8fb9-5df7d784fe25
geomean(w) # geometric mean

# ╔═╡ 6eff056c-a471-44ee-b530-61903e9403cc
harmmean(w) # harmonic mean

# ╔═╡ b930a831-0e38-436b-b4ea-2db5dc46d96d
genmean(w, 3) # generalized/power mean

# ╔═╡ a304d11c-9872-489e-9547-c5911214dd10
# Scalar Statistics

# ╔═╡ a94e54c4-2cf2-45c8-9f25-c4b9c452818a
something(nothing, 75)

# ╔═╡ 3895238f-05bb-4e9e-802f-49015b97e11e
something(32, 82)

# ╔═╡ 59d44e0e-90e9-4681-84ce-1adb7129b393
# NOTE: All the scalar statistical functions of Statistics package and StatsBase package are same. StatsBase imports Statistics but doesn't re-export it. So, all these functions are in the namespace of StatsBase.
var(rand(6), Weights(rand(6)))

# ╔═╡ b57bbb22-7f3e-48e2-8853-cabdc85486be
mean_and_var(rand(7), Weights(rand(7))) # computes mean and variance of the AbstractArray 

# ╔═╡ 2b50d05d-bc0d-4623-820c-6b8812cd0666
mean_and_std(rand(7), AnalyticWeights(rand(7)), 1) #computes mean and standard deviation along one dimension

# ╔═╡ d17b93dc-b578-464c-8ade-16ca9b5bc81f
v = rand(4000)

# ╔═╡ 147c9b48-8929-416d-944d-14d944ac7834
@btime var(v) #pretty print this to terminal

# ╔═╡ 6a866db0-6901-410d-9143-1489ccb90336
@timev var(v, mean=(mean(v))) # pretty print this to terminal

# ╔═╡ c7802a8b-1dc6-438d-a597-af9736dfdc4b
@timev varm(v, (mean(v)))

# ╔═╡ 4a0acd49-97de-4e7e-a253-2af1aee4ef2a
@timev mean(v)

# ╔═╡ 41567025-a5b4-4b80-b37c-2f7f6b8d3468
# You can see that the mean is pre calculated when using varm, stdm, covm functions

# ╔═╡ 105943bb-20d8-43a6-9ea2-b3b30a44b4a6
# For exploring more in terms of mean and variance check https://github.com/ungil/Markowitz.jl where you can solve the mean-variance optimization problem using the Critical Line Algorithm.

# ╔═╡ 3f6c2461-bb57-4670-b978-3307685d0f98
skewness(v, Weights(rand(4000)), mean(v))

# ╔═╡ 4b1ece60-c8c8-4593-908f-d27fbb488687
kurtosis(v, Weights(rand(4000)), mean(v))

# ╔═╡ cc086731-e125-4c15-884c-8e89a2f80f11
moment(v, 7, Weights(rand(4000)), mean(v)) # returns 7th order central moment of a real-valued array

# ╔═╡ 36a825b0-d776-470f-b002-17b032b49a1d
# Variation measurements

# ╔═╡ f4c7c1df-fe94-4544-96a5-5179c2cf9fe0
span(rand(4000)) # returns minimum and maximum value

# ╔═╡ 6742c288-a7db-4a85-b386-84cb6c7ff5da
variation(rand(4000)) # returns coefficient of variation of collection

# ╔═╡ 3e2bb834-7bf3-4191-bf68-77bba0f42ca9
sem(rand(4000)) # returns standard error of the mean of the collection

# ╔═╡ 37b5279f-9029-4cef-a01b-39bda31ea385
mad(rand(4000)) # Assuming that the data is normally distributed, the MAD is multiplied by 1 / quantile(Normal(), 3/4) to get a consistent estimator of standard deviation when normalize is set to true

# ╔═╡ 3a0ec8ef-0368-40aa-af43-273b8d1f4169
n = rand(-5.:5., 1, 100)

# ╔═╡ c9e5242e-956b-41b9-94aa-476f8539bd98
zs = zscore!(n, mean(n), var(n)) # calculates zscores of specific columns of DataFrame in real world data

# ╔═╡ 1dc2b0c6-6bd1-485b-8207-6e1ded905e5e
# Entropy Calculations

# ╔═╡ 9cf90913-6e56-4ad0-8f00-a2ac1d8ac790
# You can calculate continuous and discrete variables' entropies using entropy related functions in StatsBase

# ╔═╡ 337399e3-aeab-4d25-9bde-eab0f3a42bf0
renyientropy(rand(50), 2)  # calculates Renyi Entropy of order 2 of the random array

# ╔═╡ 4970dcd4-de37-4887-905e-babee5117d8a
entropy(rand(50))

# ╔═╡ 446f84c9-4be4-4afd-9328-421de00fed7e
# Quantile Related Functions

# ╔═╡ 16e3ebc9-71e4-4e2b-8ee3-5de0cc69da05
nquantile(rand(50), 7) # calculates 7 quantiles of the random collection

# ╔═╡ 57e9342e-e40b-41f8-8833-e14d06bab141
percentile(rand(50), 7) # calculates 7th percentile of the collection

# ╔═╡ 83aeea68-48ea-4a67-9922-4e832d8fa119
r = rand(50)

# ╔═╡ be605471-3458-4b0a-9994-a45b05e36d21
percentile(r, 7) == quantile(r, 0.07)

# ╔═╡ 824ae35a-3dca-4019-8bb6-105884dd1dcf
iqr(r) == percentile(r, 75) - percentile(r, 25) # computes interquantile range of collection

# ╔═╡ 3fa5be08-db89-4636-b5e4-ea82ee175fc8
mode(r)

# ╔═╡ 712bbd87-1084-4c1b-9a8a-7cb5b422e476
# Summary

# ╔═╡ 96359bb0-e0f7-4d21-b887-40b99cf2b946
summarystats(r)

# ╔═╡ 72169c85-1e3e-4fd2-aed4-9c47515cb0a7
describe(r) # pretty print stats to the terminal

# ╔═╡ dc23b7b5-811c-4fe2-bd3f-bc9c83a7b5cd
# Deviation Calculation

# ╔═╡ ef04e43d-0652-44c7-a352-317e3f2a5feb
a1 = rand(50)

# ╔═╡ 603cf7c4-dc2d-418c-82ff-87ace5ad24fe
a2 = rand(50)

# ╔═╡ 2b6e359d-a225-4618-9b9e-7d7cd6a2cdfc
counteq(a1, a2) # count number of indices of arrays where both are same

# ╔═╡ 8d8d5ab1-6b3a-4214-9731-374b2d7eeb75
countne(a1, a2) # count number of indices of arrays which are not equal

# ╔═╡ e5ec7d6d-8928-4f0d-9d93-c9e354a32f90
sqL2dist(a1, a2) # calculate squared L2 distance between two arrays

# ╔═╡ e4960e05-cdea-4343-b04e-a96eaa240c06
msd(a1, a2) # mean squared deviation between two arrays

# ╔═╡ 5b7ecc53-a85d-4e12-b706-b1c0ff12e6ac
maxad(a1, a2) # maximum absolute deviation between two arrays

# ╔═╡ c4209847-54b1-43d3-bd58-e1e2bff9c5ee
# Normalized and Un-normalized covariance matrix

# ╔═╡ dfc08059-c299-4bec-a0f1-012e4b12107b
# Scatter Matrix/Un-normalized matrix

# ╔═╡ 98251f45-61ee-4240-853f-29c4db371b1e
scattermat(rand(0:1, 50, 50), Weights(rand(50)), mean=nothing, dims=1) #computes un-normalised covariance matrix

# ╔═╡ dc4b5c6a-01ef-49de-b29b-63ebf88da2b4
# Normalized matrix

# ╔═╡ 37b6a638-a3c7-454e-a9dc-3db043c7ac9e
cov(a1, a2)

# ╔═╡ 91a1f2da-f644-4b51-9c0f-54f4e95d79ab
cov(a1, AnalyticWeights(rand(50)))

# ╔═╡ b7641624-4723-4a40-b514-d4b59330f991
mat = rand(0:1, 50, 50)

# ╔═╡ ec1cbe02-9be8-432b-99e9-adacb82e8a25
cv = cov(mat, Weights(r))

# ╔═╡ 612ff3d2-722b-4a8a-b6bd-e51342c4e673
cr = cor(mat, Weights(r), dims=2) # compute Pearson correlation matrix along dimensions with weightings.

# ╔═╡ be615294-aa9f-44ef-8870-c89fad6c3d01
mean_and_cov(rand(0:1, 50, 50), Weights(rand(50)), 2) #vardim=1 indicates along columns and vardim=2 indicates along rows

# ╔═╡ 62a35de5-71cb-4518-a87d-16022948325f
# cov2cor and cor2cov not defined

# ╔═╡ 2643b08c-ff8f-4c4e-92bb-2104ff124033
# Counts

# ╔═╡ 3be29d22-d15a-49b4-b1b0-d0a976aa60ea
counts([1, 2, 2, 3, 4, 5, 5, 5, 7, 7]) # computes number of times each number from 1 to 7 appears in matrix

# ╔═╡ 59dc72f9-ca20-4a78-ba92-10f9e56d1b51
proportions([1, 2, 2, 3, 4, 5, 5, 5, 7, 7], 7, Weights(rand(10))) # Here sum of weights is used instead of raw counts of weight vectors

# ╔═╡ e04c0125-d3d3-4afb-9a75-82fbb6928200
w1 = Weights([1, 2, 2, 3, 4, 5, 5, 5, 7, 7])

# ╔═╡ 0693ba65-a556-4679-9f9a-2b5273d147b8
s1 = span([1, 2, 2, 3, 4, 5, 5, 5, 7, 7])

# ╔═╡ bc881a15-2d5d-4ff6-9355-7bda9b39e59a
isequal(proportions([1, 2, 2, 3, 4, 5, 5, 5, 7, 7], s1), counts([1, 2, 2, 3, 4, 5, 5, 5, 7, 7], s1)/length([1, 2, 2, 3, 4, 5, 5, 5, 7, 7]))# computes proportions of each number from 1 to 7 in the matrix. Here sum of weights is used instead of raw counts of weight vectors

# ╔═╡ 775b56d5-77f9-4b1d-9a33-7b100087caeb
countmap([1, 2, 2, 3, 4, 5, 5, 5, 7, 7]) # returns a mapping of each number to its corresponding occurences

# ╔═╡ da8f5dd9-751d-4292-a1d9-48886900ad4d
proportionmap([1, 2, 2, 3, 4, 5, 5, 5, 7, 7]) # returns a mapping of each number to its corresponding proportions

# ╔═╡ e1da2f37-627f-45ce-8569-6dc7cb98e65c
oldarray = rand(1:10, 10)

# ╔═╡ 70453f7c-b991-4311-8999-277cab83992c
addcounts!(oldarray, [1, 2, 2, 3, 4, 5, 5, 5, 7, 7], 1:10) # add number of occurences of  in the newarray of each value to oldarray

# ╔═╡ 5893bc3a-0f4c-4eee-8fab-b05213073854
# Ranking correlations

# ╔═╡ 5a75e713-b760-4fbe-b087-f8ea3bd02e1a
ordinalrank([1, 2, 2, 3, 4, 5, 5, 5, 7, 7]) # as the name suggests return "1234" ranking of an array

# ╔═╡ d58bfbb1-e048-4963-b893-e91075bc9b5c
competerank([1, 2, 2, 3, 4, 5, 5, 5, 7, 7]) # return "1224" ranking or standard competition ranking of an array

# ╔═╡ 5f88e552-434c-4afa-817b-d983120bb1c0
denserank([1, 2, 2, 3, 4, 5, 5, 5, 7, 7]) # return "1223" ranking or dense ranking of an array

# ╔═╡ 3c610beb-98a1-40cb-bce3-44653d15497b
tiedrank([1, 2, 2, 3, 4, 5, 5, 5, 7, 7]) # return tied or fractional or "1 2.5 2.5 4" ranking of an array

# ╔═╡ 929042c8-08f3-4b83-8386-2bf74cf17c57
# Sampling

# ╔═╡ 6f78cac2-3edc-4939-b0d4-018eb1c93713
sample(Random.GLOBAL_RNG, rand(50), Weights(rand(50)))

# ╔═╡ 02159230-0fbd-470e-be4b-1e42f7ff8117
direct_sample!(Random.GLOBAL_RNG, rand(50), rand(50)) # not yet released

# ╔═╡ a2762fe5-a185-4d96-a64a-f4e0f7db4fa1
samplepair(Random.GLOBAL_RNG, 7)

# ╔═╡ 1f0947d3-8b60-4b1b-ba72-0b6b9d59d9b0
knuths_sample!(Random.GLOBAL_RNG, rand(50), rand(50)) # not yet released

# ╔═╡ 22089e17-fb61-48e1-8bb4-6e8041227490
alias_sample!(Random.GLOBAL_RNG, rand(50), rand(50)) # not yet released

# ╔═╡ 67fbd540-090e-4d49-9a34-6e40b9676047
# Empirical Estimation

# ╔═╡ 1d21c5f0-8f8c-42cd-94e9-4d2b26904399
fit(Histogram, [7.],  1:20, closed=:left)

# ╔═╡ f02a8c8a-06ad-4d96-822d-6309971c1229
h = fit(Histogram, [7.],  -20:20, closed=:right)

# ╔═╡ b24a29e2-5a1e-4f9e-93e3-a3fee0d9efdb
normalize(h, mode=:density)

# ╔═╡ 7e5f2cae-9ad3-4eb0-84a1-56adf7b2dedf
# Auto Covariance and Auto Correlation

# ╔═╡ d9d86abc-521c-4a3e-b848-9624ef39313d
x2 = rand(-3.:3., 10, 2)

# ╔═╡ 5d32e2fd-b4a1-4277-bb41-a5117fb81d4a
x2_ = view(x2, :, 1)

# ╔═╡ 42a3f895-ccb1-4d4c-972a-349ddfa9a2a2
autocov(x2_)

# ╔═╡ 6896cf3a-0c3e-4d13-aa8c-850052c5cd40
autocor(x2_)

# ╔═╡ 2384e3b5-1941-45ca-9411-01daceddce3f
# Cross Covariance and Cross Correlation

# ╔═╡ c4bc6b9c-477c-435e-a116-45bb31e28c18
crosscov(x2_, x2_)

# ╔═╡ 75336b47-8a61-4bd6-b55b-7dba3face299
crosscor(x2_, x2_)

# ╔═╡ bebfebfc-cee4-4a10-9bda-809e8fe05b0a
# Multivariate Summary Statistics

# ╔═╡ 30739378-90d2-4bf1-94a3-e0c4d35b333e
X1 = rand(1:20, 4, 3)

# ╔═╡ bb9f29e0-6226-417f-b3d2-6642d36e36e8
partialcor(view(X1,:,1), view(X1,:,2), view(X1,:,3)) ≈ 0.919145 # it should be equal to 0.919145 rtol=1e-6

# ╔═╡ ec34ec64-07f7-47bb-a830-29d05ade1d46
X = [1 2 5
     4 1 6
     4 0 4]

# ╔═╡ 884d37ea-372e-4b26-9202-73c5cb5d8978
genvar(X) ≈ det(X) # since the matrix isn't a vector, genvar outputs determinant of the matrix rather than variance of the matrix

# ╔═╡ a0a1df9e-1f4f-4cb7-aebd-36a34e984bcc
totalvar(X) ≈ sum(Diagonal(X)) # since the matrix isn't a vector, totalvar outputs sum of diagonal elements of the matrix

# ╔═╡ e66814d4-9b3a-4e8a-9050-c894b453f8f3
# Miscellaneous functions

# ╔═╡ 53bdf461-12ee-499d-b434-303a06ae8803
# Most of the popularly used R/MATLAB/Python Vectorized Routines which are not covered in StatsBase.jl are available in the package VectorizedRoutines.jl. 

# ╔═╡ 4eeeb55c-4a2e-412d-a5ea-fdea1b02496b
rle([1,1,1,2,2,3,3,3,3,2,2,2]) # run-length encoding of a vector as a tuple where tuples have two elements: a vector of input values, and a count of how many times each element appears in succession. 

# ╔═╡ f2c23712-7322-43ea-900e-3a537cbf6f1b
z = [1, 1, 2, 2, 2, 3, 1, 2, 2, 3, 3, 3, 3]

# ╔═╡ 721868a1-5242-4cbd-af85-d6dffe016a68
(vals, lens) = rle(z)

# ╔═╡ cd04de73-5886-4aef-8b13-edb1e371995b
inverse_rle(vals, lens) == z

# ╔═╡ fb816c98-c5af-4af4-934f-5853a085757b
x1 = [rand(10) for _ in 1:5]

# ╔═╡ f34e04a6-3426-4e8a-8924-c764185db911
y1 = [rand(Float32, 10) for _ in 1:6]

# ╔═╡ 043f2fda-5043-42a0-ad93-35052db6161f
z1 = [Vector{Any}(rand(Float32, 10)) for _ in 1:7]

# ╔═╡ 02bffed7-e859-481e-aafd-98d70fd3ab1e
pairwise(Euclidean(), x1, y1) # calculates pairwise distances also available in Distances.jl

# ╔═╡ 22dcd4cb-5b3c-4295-b69c-63a0295bbe0a
indicatormat([1 2 2], 2) # construct a map from element to index

# ╔═╡ 841bacca-3ce8-47ae-b38a-2671e551856b
s = [1, 1, 2, 2, 2, 3, 1, 2, 2, 3, 3, 3, 3, 2]

# ╔═╡ 9b446478-166d-4362-89a8-ebeee2fa6660
b = [true, false, false, true, false, true, true, false]

# ╔═╡ 3a7b82ed-7979-4b12-8402-d3d9de6d36ab
levelsmap(s) == Dict(2=>2, 3=>3, 1=>1)

# ╔═╡ 4dd6624b-38ff-41bb-82fe-228dfb09f532
# Abstraction for Statistical Models

# ╔═╡ 9c85c8aa-0b70-46c8-a6ca-516229a88810


# ╔═╡ 540452cf-61de-4703-a403-66fa67cfb650
# Data Transformations

# ╔═╡ 26d13f87-cbad-4314-9ee0-7f50423e9790
# For many machine learning algorithms, standardisation of datasets is a must-have.
# Individual characteristics that don't seem like conventional normally distributed data may underperform these approaches. 

# ╔═╡ 9019e93b-51e0-4b15-86d3-2fa23510811c
# During standardisation, data points are transformed into standard scores by eliminating the mean and scaling the variance to one unit. 

# ╔═╡ 6d3b56a8-be8b-4990-bc32-4864cb2832a7
ZScoreTransform

# ╔═╡ cc853846-6ad3-4b42-9eff-cab222d51a08
train = rand(Normal(1,10),(100,1000))

# ╔═╡ e2b46e2a-3648-4d49-ab99-42c662f51432
test  = rand(Normal(1,5),(100,100))

# ╔═╡ 2e75e189-b0fc-4c89-9b04-031057e3b81a
mean(train,dims=2)

# ╔═╡ 1f50c148-1563-4083-a674-8e05c2156133
std(train,dims=2)

# ╔═╡ d420c5a5-9307-4fe4-96f4-c735ca2a6cc4
mean(test,dims=2)

# ╔═╡ 2f828e57-28fa-4b52-b7a4-a8b7f97c1782
std(test,dims=2)

# ╔═╡ e24853be-9fdd-449f-99e7-d85f81818ee2
# Train the ZScoreTransform

# ╔═╡ 0065d8a9-845f-4952-b17f-d8c66712f541
train_std = StatsBase.fit(ZScoreTransform, train , dims=2)

# ╔═╡ ddc09953-e2bc-4d69-9411-2d67e0bfc69c
StatsBase.transform!(train_std,train)

# ╔═╡ d8712d87-bb1f-4cd3-a346-a8bbbdfdc54d
mean(train,dims=2)

# ╔═╡ a0e8042e-c331-4161-93f4-6bfd70b30ab3
std(train,dims=2)

# ╔═╡ f52ae247-be2a-4828-b0cb-ba8c609547d9
StatsBase.transform!(train_std,test)

# ╔═╡ 4ceb25a1-a464-45bb-8565-1e4b2b92dc5e
size(train_std.mean)

# ╔═╡ d2bd8e43-5c91-42fc-9514-0e28644bbca5
size(train_std.scale)

# ╔═╡ a5c29a74-6897-45b2-884a-aeb45b240cec
# UnitRangeTransform

# ╔═╡ 63f3b934-0bc1-4a4d-ba24-1bdb0ac84491
x = [0.0 -0.5 0.5; 0.0 1.0 2.0]

# ╔═╡ e6474e86-ef76-4951-a7be-b6b252453b08
d = fit(UnitRangeTransform, x, dims=2)

# ╔═╡ 4a42fb78-f66c-4645-90d3-348c3c84d92c
urt = StatsBase.transform(d, x)

# ╔═╡ e5e2df72-ae90-430c-a0cc-9fdc7431e936
# standardize

# ╔═╡ 9dfb43df-794b-4a2e-887c-f17639479105
standardize(ZScoreTransform, [0.0 -0.5 0.5; 0.0 1.0 2.0], dims=2)

# ╔═╡ 9a24aa90-634e-49b1-a5fa-76d2643a98bb
standardize(UnitRangeTransform, [0.0 -0.5 0.5; 0.0 1.0 2.0], dims=2)

# ╔═╡ 25411526-e55e-4ee3-8ade-0637c313ca53
# Reconstruct

# ╔═╡ c48e85d4-81a1-48ec-83b7-c9991da3a8bb
StatsBase.reconstruct(d, urt) == x # reconstructs the originally scaled data from a transformed vector or matrix

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
StatsKit = "2cb19f9e-ec4d-5c53-8573-a4542a68d3f0"

[compat]
BenchmarkTools = "~1.1.4"
Distributions = "~0.25.14"
Plots = "~1.15.2"
StatsBase = "~0.33.9"
StatsKit = "~0.3.1"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[AbstractFFTs]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "485ee0867925449198280d4af84bdb46a2a404d0"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.0.1"

[[Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "84918055d15b3114ede17ac6a7182f68870c16f7"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.3.1"

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Arpack]]
deps = ["Arpack_jll", "Libdl", "LinearAlgebra"]
git-tree-sha1 = "2ff92b71ba1747c5fdd541f8fc87736d82f40ec9"
uuid = "7d9fca2a-8960-54d3-9f78-7d1dccf2cb97"
version = "0.4.0"

[[Arpack_jll]]
deps = ["Libdl", "OpenBLAS_jll", "Pkg"]
git-tree-sha1 = "e214a9b9bd1b4e1b4f15b22c0994862b66af7ff7"
uuid = "68821587-b530-5797-8361-c406ea357684"
version = "3.5.0+3"

[[Arrow]]
deps = ["ArrowTypes", "BitIntegers", "CodecLz4", "CodecZstd", "DataAPI", "Dates", "Mmap", "PooledArrays", "SentinelArrays", "Tables", "TimeZones", "UUIDs"]
git-tree-sha1 = "b00e6eaba895683867728e73af78a00218f0db10"
uuid = "69666777-d1a9-59fb-9406-91d4454c9d45"
version = "1.6.2"

[[ArrowTypes]]
deps = ["UUIDs"]
git-tree-sha1 = "a0633b6d6efabf3f76dacd6eb1b3ec6c42ab0552"
uuid = "31f734f8-188a-4ce0-8406-c8a06bd891cd"
version = "1.2.1"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "a4d07a1c313392a77042855df46c5f534076fab9"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.0.0"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Statistics", "UUIDs"]
git-tree-sha1 = "42ac5e523869a84eac9669eaceed9e4aa0e1587b"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.1.4"

[[BitIntegers]]
deps = ["Random"]
git-tree-sha1 = "f50b5a99aa6ff9db7bf51255b5c21c8bc871ad54"
uuid = "c3b6d118-76ef-56ca-8cc7-ebb389d030a1"
version = "0.2.5"

[[Bootstrap]]
deps = ["DataFrames", "Distributions", "Random", "Statistics", "StatsBase", "StatsModels"]
git-tree-sha1 = "fb4bdaa6c24fea362cc54965c3f645f7cfac659f"
uuid = "e28b5b4c-05e8-5b66-bc03-6f0c0a0a06e0"
version = "2.3.3"

[[Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[CSV]]
deps = ["Dates", "Mmap", "Parsers", "PooledArrays", "SentinelArrays", "Tables", "Unicode"]
git-tree-sha1 = "b83aa3f513be680454437a0eee21001607e5d983"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.8.5"

[[Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "f2202b55d816427cd385a9a4f3ffb226bee80f99"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+0"

[[CategoricalArrays]]
deps = ["DataAPI", "Future", "JSON", "Missings", "Printf", "RecipesBase", "Statistics", "StructTypes", "Unicode"]
git-tree-sha1 = "1562002780515d2573a4fb0c3715e4e57481075e"
uuid = "324d7699-5711-5eae-9e2f-1d82baa6b597"
version = "0.10.0"

[[ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "bdc0937269321858ab2a4f288486cb258b9a0af7"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.3.0"

[[Clustering]]
deps = ["Distances", "LinearAlgebra", "NearestNeighbors", "Printf", "SparseArrays", "Statistics", "StatsBase"]
git-tree-sha1 = "75479b7df4167267d75294d14b58244695beb2ac"
uuid = "aaaa29a8-35af-508c-8bc3-b662a17a0fe5"
version = "0.14.2"

[[CodecBzip2]]
deps = ["Bzip2_jll", "Libdl", "TranscodingStreams"]
git-tree-sha1 = "2e62a725210ce3c3c2e1a3080190e7ca491f18d7"
uuid = "523fee87-0ab8-5b00-afb7-3ecf72e48cfd"
version = "0.7.2"

[[CodecLz4]]
deps = ["Lz4_jll", "TranscodingStreams"]
git-tree-sha1 = "59fe0cb37784288d6b9f1baebddbf75457395d40"
uuid = "5ba52731-8f18-5e0d-9241-30f10d1ec561"
version = "0.4.0"

[[CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "ded953804d019afa9a3f98981d99b33e3db7b6da"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.0"

[[CodecZstd]]
deps = ["TranscodingStreams", "Zstd_jll"]
git-tree-sha1 = "d19cd9ae79ef31774151637492291d75194fc5fa"
uuid = "6b39b394-51ab-5f42-8807-6242bab2b4c2"
version = "0.7.0"

[[ColorSchemes]]
deps = ["ColorTypes", "Colors", "FixedPointNumbers", "Random"]
git-tree-sha1 = "9995eb3977fbf67b86d0a0a0508e83017ded03f2"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.14.0"

[[ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[Combinatorics]]
git-tree-sha1 = "08c8b6831dc00bfea825826be0bc8336fc369860"
uuid = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"
version = "1.0.2"

[[CommonSolve]]
git-tree-sha1 = "68a0743f578349ada8bc911a5cbd5a2ef6ed6d1f"
uuid = "38540f10-b2f7-11e9-35d8-d573e4eb0ff2"
version = "0.2.0"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "727e463cfebd0c7b999bbf3e9e7e16f254b94193"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.34.0"

[[CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f74e9d5388b8620b4cee35d4c5a618dd4dc547f4"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.3.0"

[[Contour]]
deps = ["StaticArrays"]
git-tree-sha1 = "9f02045d934dc030edad45944ea80dbd1f0ebea7"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.5.7"

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

[[Distances]]
deps = ["LinearAlgebra", "Statistics", "StatsAPI"]
git-tree-sha1 = "abe4ad222b26af3337262b8afb28fab8d215e9f8"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.3"

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

[[EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "92d8f9f208637e8d2d28c664051a00569c01493d"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.1.5+1"

[[Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b3bfd02e98aedfa5cf885665493c5598c350cd2f"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.2.10+0"

[[ExprTools]]
git-tree-sha1 = "b7e3d17636b348f005f11040025ae8c6f645fe92"
uuid = "e2ba6199-217a-4e67-a87a-7c52f15ade04"
version = "0.1.6"

[[FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "Pkg", "Zlib_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "d8a578692e3077ac998b50c0217dfd67f21d1e5f"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.0+0"

[[FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "f985af3b9f4e278b1d24434cbb546d6092fca661"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.4.3"

[[FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3676abafff7e4ff07bbd2c42b3d8201f31653dcc"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.9+8"

[[FillArrays]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "Statistics"]
git-tree-sha1 = "7c365bdef6380b29cfc5caaf99688cd7489f9b87"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "0.12.2"

[[FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "87eb71354d8ec1a96d4a7636bd57a7347dde3ef9"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.4+0"

[[FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[GLM]]
deps = ["Distributions", "LinearAlgebra", "Printf", "Reexport", "SparseArrays", "SpecialFunctions", "Statistics", "StatsBase", "StatsFuns", "StatsModels"]
git-tree-sha1 = "f564ce4af5e79bb88ff1f4488e64363487674278"
uuid = "38e38edf-8417-5370-95a0-9cbb8c7f171a"
version = "1.5.1"

[[GR]]
deps = ["Base64", "DelimitedFiles", "LinearAlgebra", "Printf", "Random", "Serialization", "Sockets", "Test", "UUIDs"]
git-tree-sha1 = "1185d50c5c90ec7c0784af7f8d0d1a600750dc4d"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.49.1"

[[GeometryBasics]]
deps = ["EarCut_jll", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "15ff9a14b9e1218958d3530cc288cf31465d9ae2"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.3.13"

[[Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "7bf67e9a481712b3dbe9cb3dac852dc4b1162e02"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.68.3+0"

[[Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "44e3b40da000eab4ccb1aecdc4801c040026aeb5"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.13"

[[HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "8a954fed8ac097d5be04921d595f741115c1b2ad"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+0"

[[HypothesisTests]]
deps = ["Combinatorics", "Distributions", "LinearAlgebra", "Random", "Rmath", "Roots", "Statistics", "StatsBase"]
git-tree-sha1 = "a82a0c7e790fc16be185ce8d6d9edc7e62d5685a"
uuid = "09f84164-cd44-5f33-b23f-e6b0d136a0d5"
version = "0.10.4"

[[IniFile]]
deps = ["Test"]
git-tree-sha1 = "098e4d2c533924c921f9f9847274f2ad89e018b8"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.0"

[[IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "d979e54b71da82f3a65b62553da4fc3d18c9004c"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2018.0.3+2"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[Interpolations]]
deps = ["AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "Requires", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "61aa005707ea2cebf47c8d780da8dc9bc4e0c512"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.13.4"

[[InvertedIndices]]
deps = ["Test"]
git-tree-sha1 = "15732c475062348b0165684ffe28e85ea8396afc"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.0.0"

[[IrrationalConstants]]
git-tree-sha1 = "f76424439413893a832026ca355fe273e93bce94"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.0"

[[IterTools]]
git-tree-sha1 = "05110a2ab1fc5f932622ffea2a003221f4782c18"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.3.0"

[[IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "642a199af8b68253517b80bd3bfd17eb4e84df6e"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.3.0"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[JSON3]]
deps = ["Dates", "Mmap", "Parsers", "StructTypes", "UUIDs"]
git-tree-sha1 = "b3e5984da3c6c95bcf6931760387ff2e64f508f3"
uuid = "0f8b85d8-7281-11e9-16c2-39a750bddbf1"
version = "1.9.1"

[[JSONSchema]]
deps = ["HTTP", "JSON", "ZipFile"]
git-tree-sha1 = "b84ab8139afde82c7c65ba2b792fe12e01dd7307"
uuid = "7d188eb4-7ad8-530c-ae41-71a32a6d4692"
version = "0.3.3"

[[KernelDensity]]
deps = ["Distributions", "DocStringExtensions", "FFTW", "Interpolations", "StatsBase"]
git-tree-sha1 = "591e8dc09ad18386189610acafb970032c519707"
uuid = "5ab0869b-81aa-558d-bb23-cbf5423bbe9b"
version = "0.6.3"

[[LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[LaTeXStrings]]
git-tree-sha1 = "c7f1c695e06c01b95a67f0cd1d34994f3e7db104"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.2.1"

[[Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "Printf", "Requires"]
git-tree-sha1 = "a4b12a1bd2ebade87891ab7e36fdbce582301a92"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.6"

[[LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"

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

[[Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "761a393aeccd6aa92ec3515e428c26bf99575b3b"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+0"

[[Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "42b62845d70a619f063a7da093d995ec8e15e778"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+1"

[[Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Loess]]
deps = ["Distances", "LinearAlgebra", "Statistics"]
git-tree-sha1 = "b5254a86cf65944c68ed938e575f5c81d5dfe4cb"
uuid = "4345ca2d-374a-55d4-8d30-97f9976e7612"
version = "0.5.3"

[[LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "3d682c07e6dd250ed082f883dc88aee7996bf2cc"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.0"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[Lz4_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "5d494bc6e85c4c9b626ee0cab05daa4085486ab1"
uuid = "5ced341a-0733-55b8-9ab6-a4889d929147"
version = "1.9.3+0"

[[MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "Pkg"]
git-tree-sha1 = "c253236b0ed414624b083e6b72bfe891fbd2c7af"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2021.1.1+1"

[[MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "0fb723cd8c45858c22169b2e42269e53271a6df7"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.7"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MathOptInterface]]
deps = ["BenchmarkTools", "CodecBzip2", "CodecZlib", "JSON", "JSONSchema", "LinearAlgebra", "MutableArithmetics", "OrderedCollections", "SparseArrays", "Test", "Unicode"]
git-tree-sha1 = "575644e3c05b258250bb599e57cf73bbf1062901"
uuid = "b8f27783-ece8-5eb3-8dc8-9495eed66fee"
version = "0.9.22"

[[MathProgBase]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "9abbe463a1e9fc507f12a69e7f29346c2cdc472c"
uuid = "fdba3010-5040-5b88-9595-932c9decdf73"
version = "0.7.8"

[[MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "Random", "Sockets"]
git-tree-sha1 = "1c38e51c3d08ef2278062ebceade0e46cefc96fe"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.0.3"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Measures]]
git-tree-sha1 = "e498ddeee6f9fdb4551ce855a46f54dbd900245f"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.1"

[[Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "2ca267b08821e86c5ef4376cffed98a46c2cb205"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.1"

[[MixedModels]]
deps = ["Arrow", "DataAPI", "Distributions", "GLM", "JSON3", "LazyArtifacts", "LinearAlgebra", "Markdown", "NLopt", "PooledArrays", "ProgressMeter", "Random", "SparseArrays", "StaticArrays", "Statistics", "StatsBase", "StatsFuns", "StatsModels", "StructTypes", "Tables"]
git-tree-sha1 = "f318e42a48ec0a856292bafeec6b07aed3f6d600"
uuid = "ff71e718-51f3-5ec2-a782-8ffcbfa3c316"
version = "4.1.1"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[Mocking]]
deps = ["ExprTools"]
git-tree-sha1 = "748f6e1e4de814b101911e64cc12d83a6af66782"
uuid = "78c3b35d-d492-501b-9361-3d52fe80e533"
version = "0.7.2"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[MultivariateStats]]
deps = ["Arpack", "LinearAlgebra", "SparseArrays", "Statistics", "StatsBase"]
git-tree-sha1 = "8d958ff1854b166003238fe191ec34b9d592860a"
uuid = "6f286f6a-111f-5878-ab1e-185364afe411"
version = "0.8.0"

[[MutableArithmetics]]
deps = ["LinearAlgebra", "SparseArrays", "Test"]
git-tree-sha1 = "3927848ccebcc165952dc0d9ac9aa274a87bfe01"
uuid = "d8a4904e-b15c-11e9-3269-09a3773c0cb0"
version = "0.2.20"

[[NLopt]]
deps = ["MathOptInterface", "MathProgBase", "NLopt_jll"]
git-tree-sha1 = "d80cb3327d1aeef0f59eacf225e000f86e4eee0a"
uuid = "76087f3c-5699-56af-9a33-bf431cd00edd"
version = "0.6.3"

[[NLopt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "2b597c46900f5f811bec31f0dcc88b45744a2a09"
uuid = "079eb43e-fd8e-5478-9966-2cf3e3edb778"
version = "2.7.0+0"

[[NaNMath]]
git-tree-sha1 = "bfe47e760d60b82b66b61d2d44128b62e3a369fb"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "0.3.5"

[[NearestNeighbors]]
deps = ["Distances", "StaticArrays"]
git-tree-sha1 = "16baacfdc8758bc374882566c9187e785e85c2f0"
uuid = "b8a86587-4115-5ab1-83bc-aa920d37bbce"
version = "0.4.9"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[OffsetArrays]]
deps = ["Adapt"]
git-tree-sha1 = "c0f4a4836e5f3e0763243b8324200af6d0e0f90c"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.10.5"

[[Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7937eda4681660b4d6aeeecc2f7e1c81c8ee4e2f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+0"

[[OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "15003dcb7d8db3c6c857fda14891a539a8f2705a"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.10+0"

[[OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[PCRE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b2a7af664e098055a7529ad1a900ded962bca488"
uuid = "2f80f16e-611a-54ab-bc61-aa92de5b98fc"
version = "8.44.0+0"

[[PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "4dd403333bcf0909341cfe57ec115152f937d7d8"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.1"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "bfd7d8c7fd87f04543810d9cbd3995972236ba1b"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "1.1.2"

[[Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[PlotThemes]]
deps = ["PlotUtils", "Requires", "Statistics"]
git-tree-sha1 = "a3a964ce9dc7898193536002a6dd892b1b5a6f1d"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "2.0.1"

[[PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "c67334c786157d6ef091ce622b365d3d60b1e2c4"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.0.12"

[[Plots]]
deps = ["Base64", "Contour", "Dates", "FFMPEG", "FixedPointNumbers", "GR", "GeometryBasics", "JSON", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "PlotThemes", "PlotUtils", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs"]
git-tree-sha1 = "f3a57a5acc16a69c03539b3684354cbbbb72c9ad"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.15.2"

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

[[ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "afadeba63d90ff223a6a48d2009434ecee2ec9e8"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.7.1"

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

[[Ratios]]
deps = ["Requires"]
git-tree-sha1 = "7dff99fbc740e2f8228c6878e2aad6d7c2678098"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.1"

[[RecipesBase]]
git-tree-sha1 = "44a75aa7a527910ee3d1751d1f0e4148698add9e"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.1.2"

[[RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "RecipesBase"]
git-tree-sha1 = "e377b29ebe56fadd8b40b04d8eb117c98d0a9960"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.3.6"

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "4036a3bd08ac7e968e27c203d45f5fff15020621"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.1.3"

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

[[Roots]]
deps = ["CommonSolve", "Printf", "Setfield"]
git-tree-sha1 = "8d68de19105123a98091ba713a836ea594c07b95"
uuid = "f2b01f46-fcfa-551c-844a-d8ac1e96c665"
version = "1.3.1"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Scratch]]
deps = ["Dates"]
git-tree-sha1 = "0b4b7f1393cff97c33891da2a0bf69c6ed241fda"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.0"

[[SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "54f37736d8934a12a200edea2f9206b03bdf3159"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.3.7"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "Requires"]
git-tree-sha1 = "fca29e68c5062722b5b4435594c3d1ba557072a3"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "0.7.1"

[[SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[ShiftedArrays]]
git-tree-sha1 = "22395afdcf37d6709a5a0766cc4a5ca52cb85ea0"
uuid = "1277b4bf-5013-50f5-be3d-901d8477a67a"
version = "1.0.0"

[[Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

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

[[StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "3240808c6d463ac46f1c1cd7638375cd22abbccb"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.2.12"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[StatsAPI]]
git-tree-sha1 = "1958272568dc176a1d881acb797beb909c785510"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.0.0"

[[StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "fed1ec1e65749c4d96fc20dd13bea72b55457e62"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.9"

[[StatsFuns]]
deps = ["IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "20d1bb720b9b27636280f751746ba4abb465f19d"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "0.9.9"

[[StatsKit]]
deps = ["Bootstrap", "CSV", "CategoricalArrays", "Clustering", "DataFrames", "Distances", "Distributions", "GLM", "HypothesisTests", "KernelDensity", "Loess", "MixedModels", "MultivariateStats", "Reexport", "ShiftedArrays", "Statistics", "StatsBase", "TimeSeries"]
git-tree-sha1 = "9888fa88a0ea16dd397af86d906fee56f4d1dd06"
uuid = "2cb19f9e-ec4d-5c53-8573-a4542a68d3f0"
version = "0.3.1"

[[StatsModels]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "Printf", "ShiftedArrays", "SparseArrays", "StatsBase", "StatsFuns", "Tables"]
git-tree-sha1 = "a209a68f72601f8aa0d3a7c4e50ba3f67e32e6f8"
uuid = "3eaba693-59b7-5ba5-a881-562e759f1c8d"
version = "0.6.24"

[[StructArrays]]
deps = ["Adapt", "DataAPI", "StaticArrays", "Tables"]
git-tree-sha1 = "1700b86ad59348c0f9f68ddc95117071f947072d"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.1"

[[StructTypes]]
deps = ["Dates", "UUIDs"]
git-tree-sha1 = "e36adc471280e8b346ea24c5c87ba0571204be7a"
uuid = "856f2bd8-1eba-4b0a-8007-ebc267875bd4"
version = "1.7.2"

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

[[TimeSeries]]
deps = ["Dates", "DelimitedFiles", "DocStringExtensions", "RecipesBase", "Reexport", "Statistics", "Tables"]
git-tree-sha1 = "3c91141a9f2276c37c3b6bc2bd83e652d50fecbc"
uuid = "9e3dc215-6440-5c97-bce1-76c03772f85e"
version = "0.23.0"

[[TimeZones]]
deps = ["Dates", "Future", "LazyArtifacts", "Mocking", "Pkg", "Printf", "RecipesBase", "Serialization", "Unicode"]
git-tree-sha1 = "6c9040665b2da00d30143261aea22c7427aada1c"
uuid = "f269a46b-ccf7-5d73-abea-4c690281aa53"
version = "1.5.7"

[[TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "216b95ea110b5972db65aa90f88d8d89dcb8851c"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.6"

[[URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "59e2ad8fd1591ea019a5259bd012d7aee15f995c"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "0.5.3"

[[XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "1acf5bdf07aa0907e0a37d3718bb88d4b687b74a"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.9.12+0"

[[XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[ZipFile]]
deps = ["Libdl", "Printf", "Zlib_jll"]
git-tree-sha1 = "c3a5637e27e914a7a445b8d0ad063d701931e9f7"
uuid = "a5390f91-8eb1-5f08-bee0-b1d1ffed6cea"
version = "0.9.3"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "cc4bf3fdde8b7e3e9fa0351bdeedba1cf3b7f6e6"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.0+0"

[[libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "c45f4e40e7aafe9d086379e5578947ec8b95a8fb"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+0"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"

[[x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"
"""

# ╔═╡ Cell order:
# ╠═d9abc4aa-0761-11ec-1e22-49da8a331b0a
# ╠═01de7df9-40a6-4357-b267-7da5644feb79
# ╠═6b54ad19-5586-4513-94e5-705be4d1d71b
# ╠═723a49e0-1f31-41cb-bccc-6ab808b2069b
# ╠═1ad159cb-4294-4093-83cd-6de82cafa626
# ╠═1be117b7-17db-41e1-8278-36d63e6ec5c2
# ╠═735f87e9-d631-45a2-94e9-e8a5a2460613
# ╠═892d7d9f-3048-48fa-b2c3-2ca11c11b143
# ╠═a8c0864a-753f-4426-a4cd-b7fa3a025913
# ╠═268fc9b3-94f4-41b7-b7aa-7e9bd583f330
# ╠═3d56cbe2-5992-4394-968e-9bbe060ced17
# ╠═0ecd945d-cdb4-415d-898e-ffa5cbe5b421
# ╠═ae34080f-c20b-4751-97c2-7d2e69459560
# ╠═095aa3c4-b07c-4931-a460-e8faa7ce59c4
# ╠═baf32851-cfe4-428c-983f-397c7d282e4a
# ╠═666d8931-cfb5-4f82-8f84-c184530040b9
# ╠═470916ab-19b2-41c1-963a-d78fe5d4b834
# ╠═458b9ef4-2712-4b50-ad38-a64b87b559ba
# ╠═c01f8d26-8c74-41d9-beca-9cc147981135
# ╠═82217335-aeff-4fce-af72-345204a9841e
# ╠═96bac8bf-5b79-49c4-b5a2-555b9c02b96c
# ╠═32358a32-7df9-40ab-a6fb-55af911dfbda
# ╠═02695e86-154b-4359-8fb9-5df7d784fe25
# ╠═6eff056c-a471-44ee-b530-61903e9403cc
# ╠═b930a831-0e38-436b-b4ea-2db5dc46d96d
# ╠═a304d11c-9872-489e-9547-c5911214dd10
# ╠═a94e54c4-2cf2-45c8-9f25-c4b9c452818a
# ╠═3895238f-05bb-4e9e-802f-49015b97e11e
# ╠═59d44e0e-90e9-4681-84ce-1adb7129b393
# ╠═b57bbb22-7f3e-48e2-8853-cabdc85486be
# ╠═2b50d05d-bc0d-4623-820c-6b8812cd0666
# ╠═d17b93dc-b578-464c-8ade-16ca9b5bc81f
# ╠═147c9b48-8929-416d-944d-14d944ac7834
# ╠═6a866db0-6901-410d-9143-1489ccb90336
# ╠═c7802a8b-1dc6-438d-a597-af9736dfdc4b
# ╠═4a0acd49-97de-4e7e-a253-2af1aee4ef2a
# ╠═41567025-a5b4-4b80-b37c-2f7f6b8d3468
# ╠═105943bb-20d8-43a6-9ea2-b3b30a44b4a6
# ╠═3f6c2461-bb57-4670-b978-3307685d0f98
# ╠═4b1ece60-c8c8-4593-908f-d27fbb488687
# ╠═cc086731-e125-4c15-884c-8e89a2f80f11
# ╠═36a825b0-d776-470f-b002-17b032b49a1d
# ╠═f4c7c1df-fe94-4544-96a5-5179c2cf9fe0
# ╠═6742c288-a7db-4a85-b386-84cb6c7ff5da
# ╠═3e2bb834-7bf3-4191-bf68-77bba0f42ca9
# ╠═37b5279f-9029-4cef-a01b-39bda31ea385
# ╠═3a0ec8ef-0368-40aa-af43-273b8d1f4169
# ╠═c9e5242e-956b-41b9-94aa-476f8539bd98
# ╠═1dc2b0c6-6bd1-485b-8207-6e1ded905e5e
# ╠═9cf90913-6e56-4ad0-8f00-a2ac1d8ac790
# ╠═337399e3-aeab-4d25-9bde-eab0f3a42bf0
# ╠═4970dcd4-de37-4887-905e-babee5117d8a
# ╠═446f84c9-4be4-4afd-9328-421de00fed7e
# ╠═16e3ebc9-71e4-4e2b-8ee3-5de0cc69da05
# ╠═57e9342e-e40b-41f8-8833-e14d06bab141
# ╠═83aeea68-48ea-4a67-9922-4e832d8fa119
# ╠═be605471-3458-4b0a-9994-a45b05e36d21
# ╠═824ae35a-3dca-4019-8bb6-105884dd1dcf
# ╠═3fa5be08-db89-4636-b5e4-ea82ee175fc8
# ╠═712bbd87-1084-4c1b-9a8a-7cb5b422e476
# ╠═96359bb0-e0f7-4d21-b887-40b99cf2b946
# ╠═72169c85-1e3e-4fd2-aed4-9c47515cb0a7
# ╠═dc23b7b5-811c-4fe2-bd3f-bc9c83a7b5cd
# ╠═ef04e43d-0652-44c7-a352-317e3f2a5feb
# ╠═603cf7c4-dc2d-418c-82ff-87ace5ad24fe
# ╠═2b6e359d-a225-4618-9b9e-7d7cd6a2cdfc
# ╠═8d8d5ab1-6b3a-4214-9731-374b2d7eeb75
# ╠═e5ec7d6d-8928-4f0d-9d93-c9e354a32f90
# ╠═e4960e05-cdea-4343-b04e-a96eaa240c06
# ╠═5b7ecc53-a85d-4e12-b706-b1c0ff12e6ac
# ╠═c4209847-54b1-43d3-bd58-e1e2bff9c5ee
# ╠═dfc08059-c299-4bec-a0f1-012e4b12107b
# ╠═98251f45-61ee-4240-853f-29c4db371b1e
# ╠═dc4b5c6a-01ef-49de-b29b-63ebf88da2b4
# ╠═37b6a638-a3c7-454e-a9dc-3db043c7ac9e
# ╠═91a1f2da-f644-4b51-9c0f-54f4e95d79ab
# ╠═b7641624-4723-4a40-b514-d4b59330f991
# ╠═ec1cbe02-9be8-432b-99e9-adacb82e8a25
# ╠═612ff3d2-722b-4a8a-b6bd-e51342c4e673
# ╠═be615294-aa9f-44ef-8870-c89fad6c3d01
# ╠═62a35de5-71cb-4518-a87d-16022948325f
# ╠═2643b08c-ff8f-4c4e-92bb-2104ff124033
# ╠═3be29d22-d15a-49b4-b1b0-d0a976aa60ea
# ╠═59dc72f9-ca20-4a78-ba92-10f9e56d1b51
# ╠═e04c0125-d3d3-4afb-9a75-82fbb6928200
# ╠═0693ba65-a556-4679-9f9a-2b5273d147b8
# ╠═bc881a15-2d5d-4ff6-9355-7bda9b39e59a
# ╠═775b56d5-77f9-4b1d-9a33-7b100087caeb
# ╠═da8f5dd9-751d-4292-a1d9-48886900ad4d
# ╠═e1da2f37-627f-45ce-8569-6dc7cb98e65c
# ╠═70453f7c-b991-4311-8999-277cab83992c
# ╠═5893bc3a-0f4c-4eee-8fab-b05213073854
# ╠═5a75e713-b760-4fbe-b087-f8ea3bd02e1a
# ╠═d58bfbb1-e048-4963-b893-e91075bc9b5c
# ╠═5f88e552-434c-4afa-817b-d983120bb1c0
# ╠═3c610beb-98a1-40cb-bce3-44653d15497b
# ╠═929042c8-08f3-4b83-8386-2bf74cf17c57
# ╠═6f78cac2-3edc-4939-b0d4-018eb1c93713
# ╠═02159230-0fbd-470e-be4b-1e42f7ff8117
# ╠═a2762fe5-a185-4d96-a64a-f4e0f7db4fa1
# ╠═1f0947d3-8b60-4b1b-ba72-0b6b9d59d9b0
# ╠═22089e17-fb61-48e1-8bb4-6e8041227490
# ╠═67fbd540-090e-4d49-9a34-6e40b9676047
# ╠═1d21c5f0-8f8c-42cd-94e9-4d2b26904399
# ╠═f02a8c8a-06ad-4d96-822d-6309971c1229
# ╠═b24a29e2-5a1e-4f9e-93e3-a3fee0d9efdb
# ╠═7e5f2cae-9ad3-4eb0-84a1-56adf7b2dedf
# ╠═d9d86abc-521c-4a3e-b848-9624ef39313d
# ╠═5d32e2fd-b4a1-4277-bb41-a5117fb81d4a
# ╠═42a3f895-ccb1-4d4c-972a-349ddfa9a2a2
# ╠═6896cf3a-0c3e-4d13-aa8c-850052c5cd40
# ╠═2384e3b5-1941-45ca-9411-01daceddce3f
# ╠═c4bc6b9c-477c-435e-a116-45bb31e28c18
# ╠═75336b47-8a61-4bd6-b55b-7dba3face299
# ╠═bebfebfc-cee4-4a10-9bda-809e8fe05b0a
# ╠═30739378-90d2-4bf1-94a3-e0c4d35b333e
# ╠═bb9f29e0-6226-417f-b3d2-6642d36e36e8
# ╠═ec34ec64-07f7-47bb-a830-29d05ade1d46
# ╠═884d37ea-372e-4b26-9202-73c5cb5d8978
# ╠═a0a1df9e-1f4f-4cb7-aebd-36a34e984bcc
# ╠═e66814d4-9b3a-4e8a-9050-c894b453f8f3
# ╠═53bdf461-12ee-499d-b434-303a06ae8803
# ╠═4eeeb55c-4a2e-412d-a5ea-fdea1b02496b
# ╠═f2c23712-7322-43ea-900e-3a537cbf6f1b
# ╠═721868a1-5242-4cbd-af85-d6dffe016a68
# ╠═cd04de73-5886-4aef-8b13-edb1e371995b
# ╠═fb816c98-c5af-4af4-934f-5853a085757b
# ╠═f34e04a6-3426-4e8a-8924-c764185db911
# ╠═043f2fda-5043-42a0-ad93-35052db6161f
# ╠═02bffed7-e859-481e-aafd-98d70fd3ab1e
# ╠═22dcd4cb-5b3c-4295-b69c-63a0295bbe0a
# ╠═841bacca-3ce8-47ae-b38a-2671e551856b
# ╠═9b446478-166d-4362-89a8-ebeee2fa6660
# ╠═3a7b82ed-7979-4b12-8402-d3d9de6d36ab
# ╠═4dd6624b-38ff-41bb-82fe-228dfb09f532
# ╠═9c85c8aa-0b70-46c8-a6ca-516229a88810
# ╠═540452cf-61de-4703-a403-66fa67cfb650
# ╠═26d13f87-cbad-4314-9ee0-7f50423e9790
# ╠═9019e93b-51e0-4b15-86d3-2fa23510811c
# ╠═6d3b56a8-be8b-4990-bc32-4864cb2832a7
# ╠═cc853846-6ad3-4b42-9eff-cab222d51a08
# ╠═e2b46e2a-3648-4d49-ab99-42c662f51432
# ╠═2e75e189-b0fc-4c89-9b04-031057e3b81a
# ╠═1f50c148-1563-4083-a674-8e05c2156133
# ╠═d420c5a5-9307-4fe4-96f4-c735ca2a6cc4
# ╠═2f828e57-28fa-4b52-b7a4-a8b7f97c1782
# ╠═e24853be-9fdd-449f-99e7-d85f81818ee2
# ╠═0065d8a9-845f-4952-b17f-d8c66712f541
# ╠═ddc09953-e2bc-4d69-9411-2d67e0bfc69c
# ╠═d8712d87-bb1f-4cd3-a346-a8bbbdfdc54d
# ╠═a0e8042e-c331-4161-93f4-6bfd70b30ab3
# ╠═f52ae247-be2a-4828-b0cb-ba8c609547d9
# ╠═4ceb25a1-a464-45bb-8565-1e4b2b92dc5e
# ╠═d2bd8e43-5c91-42fc-9514-0e28644bbca5
# ╠═a5c29a74-6897-45b2-884a-aeb45b240cec
# ╠═63f3b934-0bc1-4a4d-ba24-1bdb0ac84491
# ╠═e6474e86-ef76-4951-a7be-b6b252453b08
# ╠═4a42fb78-f66c-4645-90d3-348c3c84d92c
# ╠═e5e2df72-ae90-430c-a0cc-9fdc7431e936
# ╠═9dfb43df-794b-4a2e-887c-f17639479105
# ╠═9a24aa90-634e-49b1-a5fa-76d2643a98bb
# ╠═25411526-e55e-4ee3-8ade-0637c313ca53
# ╠═c48e85d4-81a1-48ec-83b7-c9991da3a8bb
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
