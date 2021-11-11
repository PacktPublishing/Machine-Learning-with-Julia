### A Pluto.jl notebook ###
# v0.16.1

using Markdown
using InteractiveUtils

# ╔═╡ a75d8b3e-0769-11ec-0a8d-0779a2c94f44
using Distributions

# ╔═╡ ae640e10-8015-4846-972c-45d33aff4bd7
using Random

# ╔═╡ 3f22bbfc-12c6-48e1-a2ce-c2d673fdf8d1
rng = Random.seed!(42)

# ╔═╡ eeb51554-b9dd-4721-81db-3d7f862cc890
# Let's start of with the most popular, "Normal Distribution"

n = Normal()

# ╔═╡ 471b0226-a36a-447f-a72a-8f4f833f0c88
# We are creating random set of values which have a simple Normal Distribution (Bell Curve Shape), i.e. mean is zero, standard deviation is 1, skew is zero and a kurtosis of 3. In Normal Distribution, 68% of the values are within mean(+/-)std, 95% are within mean(+/-)2*std, 99.7% are within mean(+/-)3*std.

rd = rand(n, 100)

# ╔═╡ ef470561-eb8c-4c6d-b0c9-985e74f801a2
# It being a probability distribution, we can simply call functions for finding CDF and PDF. Other statistical functions can be applied similarly.

# The cumulative distribution function is the probability that a random variable will take a value less than or equal to the variable.

# The probability density function is the probability that a random variable will take a value exactly equal to itself.

# ╔═╡ da29b537-7def-4d69-aea0-02f23014e379
cdf(n, 1.5) - cdf(n, 0.5)

# ╔═╡ 025f79ce-0d3d-4354-8f16-1d1fede9c551
sum(pdf.(Uniform(0, 1), 0.8)) === pdf(Uniform(0, 1), 0.8)

# ╔═╡ 30585ae9-215e-446a-aa29-12f1c60ed082
# This package contains discrete and continuous univariate, multi-variate and matrix-variate probability distribution classes and their related functions.

# ╔═╡ 9114121f-4df4-49dd-804f-2c99033474cc
# This is a type of discrete mutlivariate.

# If you are unsure about what parameters the various distributions use, you can use `fieldnames` for the same.

fieldnames(Multinomial)

# ╔═╡ dd2223fe-20fa-4e04-80c7-a7bbb86458e5
# Let's try to estimate empirical distribution to a theoretical one.

fit(Normal, rd)

# [μ=0.0, σ=1] for the Normal distribution rd, and theoretically we got values almost equal to the assumption.

# ╔═╡ bc8e946c-2488-4177-b017-a7d455a9fc25
# DataTypes of Distributions package

# ╔═╡ eeafd017-8056-4c74-a29f-2429e3d5750c
#= 

The abstract datatype of the package is `Sampleable` which comprises of objects from which we can extract samples i.e. samplers and distributions. 

The type of Samplers that can be used are `VariateForm` and `ValueSupport`.

VariateForm as in if it is univariate, multi-variate or matrix-variate. 

The subtypes of ValueSupport are discrete  or continuous. 

ValueSupport type is used to extract basic information about the samples such as length, size, number of samples, etc. and to extract samples by using random sampler function.

A subtype of Sampleable is `Distribution` which combines both VariateForm types and ValueSupport types which in turn can be used to apply its probability density functions among other things.

=#

# ╔═╡ a6d477ff-5445-403f-9839-e2cad6152ce9
# Univariate Distributions

# ╔═╡ b9d0b2c0-914f-4f67-a839-50aa71958ebc
# NOTE: All distributions are immutable hence inplace vectorized evaluation has been deprecated

# ╔═╡ 1a2d1c6e-5cf9-48f9-b0fd-a3a608e805b8
# Continuous Univariate Distributions

# ╔═╡ e3278e81-5f16-4754-8dba-6bca7f10539d
a = Arcsine()

# ╔═╡ 5fc942b6-18b5-4133-994e-8f6df0c1fd33
params(a) # return values of parameters

# ╔═╡ 26be10a1-68af-4482-9f64-54c970b2e8d1
location(a) # get the left bound of the distribution

# ╔═╡ 9159c57b-ac3d-4bc0-bf89-ec2965953903
b = Beta()

# ╔═╡ a64f12cf-f4c2-468d-b883-5ff2ae51e605
extrema(b) # returns minimum and maximum values as a tuple

# ╔═╡ 9c7c3d1d-74b6-4767-ac3a-f30dc6190680
mean(b) # default mean is returned

# ╔═╡ 5919ad85-4b11-4a0d-95ff-d4aa32b7889f
entropy(b, 0.5) # compute entropy of the distribution w.r.t. the base value given

# ╔═╡ dcbfd625-a4c9-447f-9215-0eed31f23de6
pdfsquaredL2norm(b) # computes squared L2 norm of prob density of the distribution

# ╔═╡ ed33234c-91cb-4f92-9111-6f25fce99faf
b1 = BetaPrime()

# ╔═╡ 4c8ca066-2963-485d-982f-d338eab90c7b
rand(rng, b1) === quantile(b1, rand(rng)) # generate a random sample
# This will output false as rand(rng) is called two times. Generating a random sample is almost equivalent to quantile of the distribution

# ╔═╡ 3ec79418-2b81-430c-8cae-1abb29247c58
(α, β) = params(b1)

# ╔═╡ fd37d4e4-e0d7-4711-8d7e-2ff8507dc83b
rand(rng, Gamma(α)) / rand(rng, Gamma(β)) # this value is equal to rand(rng, b1)

# ╔═╡ e1e7a04a-684a-426b-b3bc-4e7767b2494f
b2 = Biweight()

# ╔═╡ 60fd87ba-08e2-4897-9cd8-187452151978
logpdf(b2, 0.5) # evaluate log of prob density at mass=0.5

# ╔═╡ f1875391-cc8d-49bb-a903-83a138594dd5
quantile(b2, 0.7) # computes inverse cumulative distribution function at 0.7

# ╔═╡ ba40b5f1-3dd6-4fe4-8557-3f87e95822da
c = Cauchy()

# ╔═╡ 324a3a13-87c5-4dc9-8d35-b5f7fbb93109
scale(c)

# ╔═╡ 8daba87d-59e8-44c6-af7d-6e4b0aca5a75
median(c)

# ╔═╡ f74c6cba-99f5-48b1-a6b9-b523ea55930d
c1 = Chernoff()

# ╔═╡ cd6a616f-9054-46f6-ab58-2023ef2732e2
cdf(c1, 0.5) + cdf(c1, -0.5) # evaluate tail probability; almost equivalent to 1

# ╔═╡ a1083141-cf94-408d-8181-bfe2e3daf9b3
var(c1) # evaluate variance of a basic Chernoff distribution

# ╔═╡ f7c41616-b468-4496-8f85-527d8b3fcfda
kurtosis(c1) # evaluate kurtosis of a basic Chernoff distribution

# ╔═╡ 12e16b48-bb71-4944-b915-f00f59633a28
skewness(c1) # evaluate skewness of a basic Chernoff distribution

# ╔═╡ 7e2ea0b4-68c3-46b2-bb76-43d2fcc959db
entropy(c1) # evaluate entropy of a basic Chernoff distribution

# ╔═╡ 5dc859a8-c12f-44da-8ac8-50896fb7c7e2
c2 = Chi(3) # Chi distribution with 3 degrees of freedom

# ╔═╡ 708ac013-715b-4df4-8a40-96501e093274
 dof(c2) # returns degrees of freedom

# ╔═╡ af163e63-604a-4f4c-b57f-b0cc00378324
pdfsquaredL2norm(c2) # returns squared L2 norm of probability density function of Chi distribution

# ╔═╡ f9f6e408-30d4-4f7e-b64f-e3a8ff8e92d1
kurtosis(c2)

# ╔═╡ 98a4752e-53af-4d29-bdea-d76577fd8a5c
sampler(c2) # Samplers can frequently rely on pre-computed values to enhance efficiency. It can be equipped with this sampler technique for batch sampling.

# ╔═╡ cfdfd9a0-9017-4116-be43-fced34b58606
mean(c2)

# ╔═╡ e289e579-30e8-4292-934c-f7d7f56886e5
gradlogpdf(c2, 0.7)

# ╔═╡ c05d0cd1-db06-4818-a05c-6b4d560c7abe
logpdf(c2, 0.5) # logarithm of prob density function at 0.5

# ╔═╡ 76c4ffc3-2d4f-4f2f-b22d-5a9a2812cbdd
 c3 = Chisq(2)

# ╔═╡ f05b9262-f373-491a-b690-b3e1854bd388
params(c3)

# ╔═╡ 9197be83-f28d-462a-800e-b572b942e87e
sampler(c3)

# ╔═╡ 83de8601-722d-4ec2-8bcd-8808984b12fd
pdfsquaredL2norm(c3)

# ╔═╡ 21474254-5742-4c22-b2ad-575f4ed2f47c
logpdf(c3, 0.5)

# ╔═╡ 1d56e469-9c7c-48c3-b997-0dbd38234f83
c4 = Cosine()

# ╔═╡ fd09566a-acdf-4999-9a32-fdfd518177e8
ccdf(c4, 0.3)

# ╔═╡ ac83ee95-5f7b-4df3-9c12-1e66e472b3d6
cdf(c4, 0.7)

# ╔═╡ b0aabc61-10f1-453c-aefa-c098d614ecd6
skewness(c4)

# ╔═╡ f9295f00-f7f6-44f1-ad1d-3bab3a628c5b
mode(c4)

# ╔═╡ 754505f8-b080-4c3d-a6b2-79d69e06e771
e = Erlang()

# ╔═╡ db1654f3-99f4-4aaf-93a6-f54be2506a39
scale(e)

# ╔═╡ 3d068866-48bd-4f9c-937d-71683bbfc7b8
rate(e)

# ╔═╡ e9d696ec-5bd5-41a9-b666-4ab504f028e7
kurtosis(e)

# ╔═╡ e836d5f3-61b3-49d8-9dce-99f455884abc
var(e)

# ╔═╡ 60095213-fd06-4b3e-a131-38cbe6d74f71
mgf(e, 1.8) # evaluates moment generating function

# ╔═╡ 597d59f3-03ed-4333-b99e-dcaf536793b3
cf(e, 8.9) # evaluates characteristic function

# ╔═╡ b4fe0130-9560-4d81-b4e0-1e3dcc3a769e
e1 = Exponential()

# ╔═╡ e6052dea-e63d-4a4f-987e-a3dffe9d3bc9
suffstats(Exponential, rand(1000))

# ╔═╡ 4974f123-952c-4626-8346-9c42697590b1
fit_mle(Exponential, rand(1000))

# ╔═╡ 0f12c5c0-823f-4e14-8256-d524cb258143
f = FDist(4.5, 7)

# ╔═╡ 084c1f11-6fe7-496b-8603-071d27573e92
entropy(f)

# ╔═╡ 4f49bdff-5c44-4c2f-b6db-753a24619d76
rand(f, 50)

# ╔═╡ 997aaa92-0227-47c7-87ea-61c0fa10ccc8
g = Gamma(4.5, 7)

# ╔═╡ 28339f8a-582a-477c-ae7b-3d3e19cd50b5
fit_mle(Gamma, rand(1000))

# ╔═╡ d757ff04-4448-4bd7-8d3c-239a5e55179b
entropy(g)

# ╔═╡ 8f24b9b2-d2b7-4308-9b64-f0c7e274463f
kurtosis(g)

# ╔═╡ 3db1002f-abc3-4781-9862-2bf82a057b81
gradlogpdf(g, 0.6)

# ╔═╡ 60859f4c-a549-4851-85c8-cc1eb1a1ea9f
mgf(g, -.4)

# ╔═╡ 652fcbda-ac03-4a90-958c-a3739b08fab0
i = InverseGamma()

# ╔═╡ b4f733ed-3069-4f81-89e2-a2c069d6b25b
params(i)

# ╔═╡ 09a52cce-ca36-4d1c-8fbc-38196bffc09d
cquantile(i, .75)

# ╔═╡ 28d6e92f-cbb5-40f6-b4f1-81fdec46456d
invlogccdf(i, -.9)

# ╔═╡ f663e150-2ebe-401c-a0bb-8a910476ee02
i1 = InverseGaussian()

# ╔═╡ 5df72ac7-1f4d-4cdd-9dea-b2260b5197e0
fit_mle(InverseGaussian, rand(10000))

# ╔═╡ 0f511fed-05f6-4970-9eba-0bc58182d91f
logccdf(i1, -.75)

# ╔═╡ 444f1b65-7eab-4550-9b08-3c83a60c7f64
p = Pareto()

# ╔═╡ 268a0e38-1ec1-4fdc-a947-c65ba851e8eb
fit_mle(Pareto, rand(10000))

# ╔═╡ 0689dbf0-255e-4c30-a88b-2851914d19f3
entropy(p)

# ╔═╡ 4fa96ad7-ed04-401b-a7ac-e71c24cb73fc
pdf(p, 1.75)

# ╔═╡ a0dbf262-25c0-4d23-9b4b-1a17b20539be
l = LogNormal()

# ╔═╡ 20437f49-3bff-44a4-ba86-b3a30689450c
logccdf(l, 0.4)

# ╔═╡ b4e49482-aa94-43a8-a472-7230ece557c0
cquantile(l, 0.75)

# ╔═╡ 488a1cf3-6a06-49c7-93c9-bcf388ea5943
fit_mle(LogNormal, rand(10000))

# ╔═╡ 76f712db-0a60-4518-a06c-3bee6d2aa08e
l1 = LogitNormal()

# ╔═╡ 67147ca1-2d89-44a8-9c11-353ee6cb293c
invlogccdf(l1, 1.4)

# ╔═╡ 3a15c778-3d84-4c65-929a-22f43bca517c
fit_mle(LogitNormal, rand(1000))

# ╔═╡ 388f32bc-debf-4f54-878e-377a58cd9a66
l2 = Logistic()

# ╔═╡ b359a15e-440a-4849-935f-2ca7af3c263e
gradlogpdf(l2, 3.5)

# ╔═╡ aeb2b5ab-3214-44b2-8eee-039ef4e9684d
skewness(l2)

# ╔═╡ 78a85346-1d4c-4c20-8191-870ca37b04bd
l3 = Laplace()

# ╔═╡ 7f59cdda-709a-45e5-b6a0-53301066a6b6
mgf(l3, 7.7)

# ╔═╡ ef057b36-8339-48ff-8440-441b63e51b15
fit_mle(Laplace, rand(1000))

# ╔═╡ 5f60603b-3d67-4cd2-9f7a-fd4837db6c1d
r = Rayleigh(2)

# ╔═╡ 77411715-da83-4f24-b915-91a2a76d207c
logcdf(r, 0.4)

# ╔═╡ 87a363c1-0eb9-4b5a-b888-0054d933de7c
entropy(r)

# ╔═╡ e20b0e9b-4e81-42a6-9af9-a2dbcf0b052c
fit_mle(Rayleigh, rand(1000))

# ╔═╡ 6cc6aa0c-fbdd-42a2-afd1-7a21929699e6
s = SymTriangularDist()

# ╔═╡ 8d65ec5d-758f-4afd-8408-fef03eb3b8c3
invlogcdf(s, -0.5)

# ╔═╡ 4b926625-2d61-4326-b12c-783803b5ac99
quantile(s, 0/95)

# ╔═╡ d8d9ed48-bd64-4a0f-9dbd-42b9115d8837
t = TDist(5)

# ╔═╡ c5b30329-c34b-45c9-92b5-fd03828d2fc1
dof(t)

# ╔═╡ e92de989-f4c3-4998-9900-61dba2b79a5d
gradlogpdf(t, 1.7)

# ╔═╡ a66a69ae-a726-4cf6-94bb-bf9b88b18efb
entropy(t)

# ╔═╡ 23b2af75-73dd-4be0-ad41-760fcc533f50
t1 = TriangularDist(1, 5, 2)

# ╔═╡ 6fe6eef3-6a85-414e-9947-1a29e235b406
rand(t1)

# ╔═╡ 8ee67312-0a6a-4fa4-b7c3-519b3f146df1
logpdf(t1, 0.34)

# ╔═╡ 37e6381a-30a4-481c-8d1c-55ccb87fb353
mgf(t1, 7.4)

# ╔═╡ 1296320b-d714-4b80-87f8-1cefb1dbf868
t2 = Triweight()

# ╔═╡ a86924e6-39ed-4f58-b60c-4473f6a9bb8d
mgf(t2, 4.8)

# ╔═╡ 76151351-4f16-4d58-b2ae-c91dde660477
cf(t2, 8.98)

# ╔═╡ 8b886e2d-6eb0-43c1-9cbd-822b5e01e8ce
u = Uniform()

# ╔═╡ 1e3a631b-e4a8-412e-a4e1-3beeace38c62
location(u)

# ╔═╡ 6d232648-2dd4-402f-8b54-e79c6608afd8
kurtosis(u)

# ╔═╡ 3b3b6e04-d25c-4aa6-ad68-7466bbb6dbc3
gradlogpdf(u, 1.5) # for all values

# ╔═╡ 49e3c863-eca3-499e-828a-dca0f4039de4
v = VonMises()

# ╔═╡ 14ab4e0f-203f-4fab-9036-3696b7ef3ab8
logpdf(v, 0.9)

# ╔═╡ 866c601b-9e48-4493-ba2e-39df9864141a
cf(v, -1.6)

# ╔═╡ ff6b783b-a2a1-43fb-b38d-b0fd967841ca
sampler(v)

# ╔═╡ 245cc832-6d01-4367-ad8b-4f1b55b5390e
w = Weibull()

# ╔═╡ 820d1231-d71f-45a6-90e0-6d22d15156a5
partype(w) # shows type of parameters

# ╔═╡ e1f9c16b-bcab-4ef5-b115-77a7a9362470
cquantile(w, 0.75) # evaluates 75th percentile of the distribution

# ╔═╡ fef0ce0e-44d6-4484-80e1-45bd5c9c7e38
invlogccdf(w, 0.3)

# ╔═╡ 21578ccb-3943-48fd-b1fd-6237bdf4f80f
x = Array(rand(rng, 1000))

# ╔═╡ 0a3bb76a-3ef7-41f5-80ca-df935932da77
fit(Weibull, collect(1:10)) #log will only return a complex result if called with a complex argument, i.e. values less than 0 and the condition α > zero(α) && θ > zero(θ) is satisfied.

# ╔═╡ c17a6aa4-79a7-426c-bdee-96039b800857
fit_mle(Weibull, x) # computes maximum likelihood estimate

# ╔═╡ b88f392c-8a1a-4acf-b3cd-c31d7a4fd627
#=
NOTE: Go through https://turing.ml/dev/tutorials/00-introduction/ to get an easy understanding of Bayesian Inferential learning in Julia using Turing.jl package. Go through https://github.com/JuliaNLSolvers/Optim.jl to get a hang of optimization of univariate and multi-variate functions. We haven't covered this in the book.
=#

# ╔═╡ b3c270fb-fa77-41d4-8f3c-718f3aac6f77
# Discrete Univariate Distributions

# ╔═╡ 22f01bfb-5ea9-4f7c-975d-e906b8ae3563
Bernoulli(0.5) === Bernoulli()

# ╔═╡ ce3cc1f3-6a54-47b2-a409-f71d8dcb7afb
ber = Bernoulli(0.3)

# ╔═╡ a1a99278-7e8e-4b4e-a795-d00d5e40465e
succprob(ber) # success probability

# ╔═╡ 99786701-3a49-4433-bb05-ab5e5fa47d1e
params(ber)

# ╔═╡ ff15af23-cb50-4441-9592-1819421a6205
skewness(ber)

# ╔═╡ 64b58c58-9ce8-4e42-911d-d4f780d7c1b6
mode(ber)

# ╔═╡ 40be7660-d642-4c48-9cbe-3396106034cc
median(ber)

# ╔═╡ 5109a629-ff2a-4bf2-8e86-78f30d05a41d
logpdf(ber, 1.5)

# ╔═╡ ba7ce037-e348-48bc-8140-238e542b29c4
ccdf(ber, 0.8)

# ╔═╡ 6b058d97-d87c-442f-b938-163095b271a5
ccdf(ber, 7)

# ╔═╡ c9a2150d-6a4f-40b3-aaa3-d659b75c57d8
mgf(ber, 6.8)

# ╔═╡ a15190b3-27ac-48e2-b5bb-d36a802b38d6
bet = BetaBinomial(6, 0.5, 0.4)

# ╔═╡ 11f55be0-b133-4522-8782-0a3e1f3fde0b
params(bet)

# ╔═╡ 4199ca17-5342-46cf-80db-fd512413f2cd
ntrials(bet)

# ╔═╡ 0d6ea1fa-1741-4400-84bd-1e364c260741
kurtosis(bet)

# ╔═╡ 86b136ca-d77f-4fdf-a0c6-0d6f26d559d9
mean(bet)

# ╔═╡ 1a0b6cb1-c981-4e4b-b94f-b96bc7843e71
cdf(bet, 0.6)

# ╔═╡ 6200b397-026f-4484-9680-025bff7e73e1
quantile(bet, 0.6)

# ╔═╡ 5308d425-1862-42c6-a305-4026876576ac
bin = Binomial()

# ╔═╡ 11b450ad-d234-4964-a953-c184d9a12098
ntrials(bin)

# ╔═╡ 1bd7bb23-cae3-4314-896e-72eb0b40c514
params(bin)

# ╔═╡ 47d3d946-3d6a-475d-b9dc-1e89e47de8c0
failprob(bin)

# ╔═╡ c25e89a0-be69-4613-be6b-aabdec176dec
var(bin)

# ╔═╡ 72e46d50-99a9-4c97-90cf-ea4e682a21ae
median(bin)

# ╔═╡ 573fafea-56ed-48e8-88ec-df36f244c8f5
kurtosis(bin)

# ╔═╡ 639e791f-01e6-4481-8df9-0a1fa2482d1b
cat = Categorical(7)

# ╔═╡ 6a67111e-9224-4459-b89b-f374a08d0be6
params(cat)

# ╔═╡ 21072c0c-e840-47a4-ba7a-a783aa7a089c
probs(cat) # probability vector

# ╔═╡ 1f409f70-fee6-414b-8c58-cd71d2a8b5a3
ncategories(cat)

# ╔═╡ f25fccd1-7478-4b92-bf82-b7f3a84dd930
ccdf(cat, rand(1000))

# ╔═╡ 38ee2580-a7a8-4dd4-b3ca-281d97a65edc
ccdf(cat, [2, 5, 3, 6])

# ╔═╡ 250622de-03a0-4675-a91f-9cdb059fcca7
cdf(cat, rand(1000))

# ╔═╡ 554abb12-c1e6-4c90-aeaf-f4c8d97379a3
cdf(cat, [2, 5, 3, 6])

# ╔═╡ 6a742c0c-a6f4-45b8-b5a0-f8c9f842773b
dir = Dirac(7.8)

# ╔═╡ 7b99a92b-699e-42d3-9e0b-60cdefc9ef0f
insupport(dir, rand(100))

# ╔═╡ ab0549c7-21a3-4028-8db2-2718d25ef5a6
entropy(dir)

# ╔═╡ 8d0c5648-4ba5-42ae-ab36-25eb69b88649
var(dir)

# ╔═╡ 3b6865f9-f8ab-4f77-ad81-b654ef3de5ae
logcdf(dir, rand(100))

# ╔═╡ e9b8f83b-beae-476b-a9be-9a6c56632f06
dis = DiscreteUniform(47, 69)

# ╔═╡ cd5cc619-d400-4266-9094-a0a83f58fbf0
probval(dis)

# ╔═╡ 7c6489db-35ec-40de-b0e0-ccf93f0a90ee
span(dis)

# ╔═╡ e425cdba-1cc9-4073-8bd1-e009bf32bb04
params(dis)

# ╔═╡ 6619fb02-1afe-4350-b8cf-2ca595c3e6a0
show(dis)

# ╔═╡ 1125bd37-fb19-45df-860d-f86fbc08d823
mean(dis)

# ╔═╡ b1bdffc4-8f7c-4714-a7be-145ecf4ad3b8
skewness(dis)

# ╔═╡ 0dfe1b52-04cf-4dd9-885d-74c8e0cac799
entropy(dis)

# ╔═╡ 992a775a-d4ab-4d73-a499-459d9fa3e776
pdf(dis)

# ╔═╡ 1b235fca-23ec-46b3-ba93-33508582bef0
cdf(dis, 7)

# ╔═╡ 9fb079ba-8eea-4fca-a170-e648717af5f4
dnp = DiscreteNonParametric([2.3, 4.5, 6.5, 7.8, 9.2], [0.4, 0.3, 0.2, 0.1, 0.0])

# ╔═╡ f4b48aef-a841-4acc-a3a1-c419a135d647
params(dnp)

# ╔═╡ 364db8a0-bd2d-49a5-bffc-de56814e5888
support(dnp)

# ╔═╡ d1918575-46e4-4876-a94c-3e232b48b4f2
probs(dnp)

# ╔═╡ d997cfbb-a5dd-4728-b0a7-9a6f2ddce42f
pdf(dnp, rand(100))

# ╔═╡ 57424fc3-2161-4772-baec-a23e82e749c4
ccdf(dnp, rand(100))

# ╔═╡ efa82d81-4fdd-455d-acc0-9a2147a5de1b
maximum(dnp)

# ╔═╡ 0f6d5f54-ba8f-4ff0-ae11-a4703bc3a5ab
minimum(dnp)

# ╔═╡ 0dfc6f69-a1c7-432e-8d35-65e0b9df8d73
entropy(dnp)

# ╔═╡ a9488b85-218e-45ea-896d-d849f485e958
kurtosis(dnp)

# ╔═╡ da9be907-3b32-4bea-8c8b-94ababcd2dc5
geo = Geometric(0.8)

# ╔═╡ 13187e58-9a5e-4313-84c3-18936f0a0aef
failprob(geo)

# ╔═╡ a5d36503-0a65-4e5a-b6b2-230f459d838d
params(geo)

# ╔═╡ f25d30ae-f2ce-461d-8e2b-cba82f61c031
var(geo)

# ╔═╡ be18640e-1d7b-4c50-b3df-bfc6ebf36089
kurtosis(geo)

# ╔═╡ 7f2bd8ab-fd0d-4764-9d71-a39b495ef1e3
entropy(geo)

# ╔═╡ 55d074c4-2128-4984-bb04-260e617066d4
logccdf(geo, 7)

# ╔═╡ 276e5bb4-ae8f-4666-9abd-59a601fe96a8
invlogcdf(geo, -2.8)

# ╔═╡ 8c1c9824-9bba-4104-92f6-35f0482299f4
cquantile(geo, 2.8)

# ╔═╡ 2e5292ee-c313-41af-8ffe-766d82769ece
hy = Hypergeometric(9, 5, 7)

# ╔═╡ eac6459d-88a1-4c92-98a1-171667fb62bc
params(hy)

# ╔═╡ 388dd1f4-39fd-4d8f-a473-e37abce5e6a1
mean(hy)

# ╔═╡ 0250c6a0-1890-4011-b1e3-fbc43516b0d3
var(hy)

# ╔═╡ 965d15a2-6027-4277-9793-767301770469
mode(hy)

# ╔═╡ 666b607b-19af-44bf-9e30-52f9c0ab248b
kurtosis(hy)

# ╔═╡ 47c63f92-f0ed-494c-9e9a-14e7cc4c6e44
entropy(hy)

# ╔═╡ 6d5db40b-23ad-44db-8442-2a0f8ab6002c
neg = NegativeBinomial()

# ╔═╡ 6555ad08-6d83-4745-93d1-d016dd40e9d7
params(neg)

# ╔═╡ e227dd5b-facf-47f4-a697-bc27bed725a9
var(neg)

# ╔═╡ bc9a8b94-d96d-42d1-986b-af74d9d66c84
skewness(neg)

# ╔═╡ 87c51191-400c-4a05-b8ea-bb9fa5292d9e
logccdf(neg, 0.4)

# ╔═╡ 61842353-23ee-454b-9aae-7c5451d094b4
quantile(neg, 0.59)

# ╔═╡ a1c4bbc4-45af-4cd8-b02c-d59b94ea1cb2
po = Poisson()

# ╔═╡ a447413e-939b-4c47-84d9-00a8f0bdb197
params(po)

# ╔═╡ 74febb89-8545-4759-b4e6-95410b1a7117
rate(po)

# ╔═╡ cd1f29ed-c476-4603-b9d3-fe700cc070b0
skewness(po)

# ╔═╡ dd4fdb1b-85bf-4326-a99b-7fa4a3ac3cbe
pb = PoissonBinomial([0.5, 0.6, 0.8, 0.6, 0.3])

# ╔═╡ 3e3ad40f-4a65-469e-af7e-0410a4918d21
ntrials(pb)

# ╔═╡ 182464ed-24ef-4abf-b98a-8b0655788b06
params(pb)

# ╔═╡ b69e36a6-62b1-4dfd-8594-bbd942e64f96
mean(pb)

# ╔═╡ de4b900b-01b4-44cb-b1e8-16c580de2b74
kurtosis(pb)

# ╔═╡ 7451dbee-0353-467b-ad97-666c1c520819
entropy(pb)

# ╔═╡ 9adfcb62-50bf-4d78-8119-746c1580a92d
modes(pb)

# ╔═╡ c2f1ed3b-9b65-44db-b8ba-1cdeabb14955
quantile(pb, 0.67)

# ╔═╡ bd569a04-5aea-4081-9b0a-45690daba964
cdf(pb, rand(100))

# ╔═╡ cfb63469-12f1-47ae-82a0-660be26051d8
sk = Skellam(7.7)

# ╔═╡ c423d947-1795-4ea3-9c23-9d5558cb581f
params(sk)

# ╔═╡ 7708ce82-755d-4618-9469-f27918656474
skewness(sk)

# ╔═╡ e06e7bb2-d372-404b-897e-6bf447eab874
mean(sk)

# ╔═╡ bb7fc26f-7e86-4c45-ac77-4b16b04e266d
kurtosis(sk)

# ╔═╡ fabc0cb0-d06f-4071-8041-b225ab028984
logpdf(sk, rand(100))

# ╔═╡ e3fd3e8e-37b6-4a79-8a77-a5bece3f6af7
cdf(sk, 7)

# ╔═╡ 99aea4e7-2063-4986-ae99-83a369cf32f6
# Truncated Distributions

# ╔═╡ 2fcc54ae-5ff8-4652-8935-b7cf7baa1e97
tbin = truncated(bin, 8, 9)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[compat]
Distributions = "~0.25.16"
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
git-tree-sha1 = "30ee06de5ff870b45c78f529a6b093b3323256a3"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.3.1"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "727e463cfebd0c7b999bbf3e9e7e16f254b94193"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.34.0"

[[CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[DataAPI]]
git-tree-sha1 = "bec2532f8adb82005476c141ec23e921fc20971b"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.8.0"

[[DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "7d9d316f04214f7efdbb6398d545446e246eff02"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.10"

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
deps = ["ChainRulesCore", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SparseArrays", "SpecialFunctions", "Statistics", "StatsBase", "StatsFuns"]
git-tree-sha1 = "f4efaa4b5157e0cdb8283ae0b5428bc9208436ed"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.16"

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
git-tree-sha1 = "a3b7b041753094f3b17ffa9d2e2e07d8cace09cd"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "0.12.3"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[IrrationalConstants]]
git-tree-sha1 = "f76424439413893a832026ca355fe273e93bce94"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.0"

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
deps = ["ChainRulesCore", "DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "1f5097e3bce576e1cdf6dc9f051ab8c6e196b29e"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.1"

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

[[Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00cfd92944ca9c760982747e9a1d0d5d86ab1e5a"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.2"

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

[[SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

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
# ╠═a75d8b3e-0769-11ec-0a8d-0779a2c94f44
# ╠═ae640e10-8015-4846-972c-45d33aff4bd7
# ╠═3f22bbfc-12c6-48e1-a2ce-c2d673fdf8d1
# ╠═eeb51554-b9dd-4721-81db-3d7f862cc890
# ╠═471b0226-a36a-447f-a72a-8f4f833f0c88
# ╠═ef470561-eb8c-4c6d-b0c9-985e74f801a2
# ╠═da29b537-7def-4d69-aea0-02f23014e379
# ╠═025f79ce-0d3d-4354-8f16-1d1fede9c551
# ╠═30585ae9-215e-446a-aa29-12f1c60ed082
# ╠═9114121f-4df4-49dd-804f-2c99033474cc
# ╠═dd2223fe-20fa-4e04-80c7-a7bbb86458e5
# ╠═bc8e946c-2488-4177-b017-a7d455a9fc25
# ╠═eeafd017-8056-4c74-a29f-2429e3d5750c
# ╠═a6d477ff-5445-403f-9839-e2cad6152ce9
# ╠═b9d0b2c0-914f-4f67-a839-50aa71958ebc
# ╠═1a2d1c6e-5cf9-48f9-b0fd-a3a608e805b8
# ╠═e3278e81-5f16-4754-8dba-6bca7f10539d
# ╠═5fc942b6-18b5-4133-994e-8f6df0c1fd33
# ╠═26be10a1-68af-4482-9f64-54c970b2e8d1
# ╠═9159c57b-ac3d-4bc0-bf89-ec2965953903
# ╠═a64f12cf-f4c2-468d-b883-5ff2ae51e605
# ╠═9c7c3d1d-74b6-4767-ac3a-f30dc6190680
# ╠═5919ad85-4b11-4a0d-95ff-d4aa32b7889f
# ╠═dcbfd625-a4c9-447f-9215-0eed31f23de6
# ╠═ed33234c-91cb-4f92-9111-6f25fce99faf
# ╠═4c8ca066-2963-485d-982f-d338eab90c7b
# ╠═3ec79418-2b81-430c-8cae-1abb29247c58
# ╠═fd37d4e4-e0d7-4711-8d7e-2ff8507dc83b
# ╠═e1e7a04a-684a-426b-b3bc-4e7767b2494f
# ╠═60fd87ba-08e2-4897-9cd8-187452151978
# ╠═f1875391-cc8d-49bb-a903-83a138594dd5
# ╠═ba40b5f1-3dd6-4fe4-8557-3f87e95822da
# ╠═324a3a13-87c5-4dc9-8d35-b5f7fbb93109
# ╠═8daba87d-59e8-44c6-af7d-6e4b0aca5a75
# ╠═f74c6cba-99f5-48b1-a6b9-b523ea55930d
# ╠═cd6a616f-9054-46f6-ab58-2023ef2732e2
# ╠═a1083141-cf94-408d-8181-bfe2e3daf9b3
# ╠═f7c41616-b468-4496-8f85-527d8b3fcfda
# ╠═12e16b48-bb71-4944-b915-f00f59633a28
# ╠═7e2ea0b4-68c3-46b2-bb76-43d2fcc959db
# ╠═5dc859a8-c12f-44da-8ac8-50896fb7c7e2
# ╠═708ac013-715b-4df4-8a40-96501e093274
# ╠═af163e63-604a-4f4c-b57f-b0cc00378324
# ╠═f9f6e408-30d4-4f7e-b64f-e3a8ff8e92d1
# ╠═98a4752e-53af-4d29-bdea-d76577fd8a5c
# ╠═cfdfd9a0-9017-4116-be43-fced34b58606
# ╠═e289e579-30e8-4292-934c-f7d7f56886e5
# ╠═c05d0cd1-db06-4818-a05c-6b4d560c7abe
# ╠═76c4ffc3-2d4f-4f2f-b22d-5a9a2812cbdd
# ╠═f05b9262-f373-491a-b690-b3e1854bd388
# ╠═9197be83-f28d-462a-800e-b572b942e87e
# ╠═83de8601-722d-4ec2-8bcd-8808984b12fd
# ╠═21474254-5742-4c22-b2ad-575f4ed2f47c
# ╠═1d56e469-9c7c-48c3-b997-0dbd38234f83
# ╠═fd09566a-acdf-4999-9a32-fdfd518177e8
# ╠═ac83ee95-5f7b-4df3-9c12-1e66e472b3d6
# ╠═b0aabc61-10f1-453c-aefa-c098d614ecd6
# ╠═f9295f00-f7f6-44f1-ad1d-3bab3a628c5b
# ╠═754505f8-b080-4c3d-a6b2-79d69e06e771
# ╠═db1654f3-99f4-4aaf-93a6-f54be2506a39
# ╠═3d068866-48bd-4f9c-937d-71683bbfc7b8
# ╠═e9d696ec-5bd5-41a9-b666-4ab504f028e7
# ╠═e836d5f3-61b3-49d8-9dce-99f455884abc
# ╠═60095213-fd06-4b3e-a131-38cbe6d74f71
# ╠═597d59f3-03ed-4333-b99e-dcaf536793b3
# ╠═b4fe0130-9560-4d81-b4e0-1e3dcc3a769e
# ╠═e6052dea-e63d-4a4f-987e-a3dffe9d3bc9
# ╠═4974f123-952c-4626-8346-9c42697590b1
# ╠═0f12c5c0-823f-4e14-8256-d524cb258143
# ╠═084c1f11-6fe7-496b-8603-071d27573e92
# ╠═4f49bdff-5c44-4c2f-b6db-753a24619d76
# ╠═997aaa92-0227-47c7-87ea-61c0fa10ccc8
# ╠═28339f8a-582a-477c-ae7b-3d3e19cd50b5
# ╠═d757ff04-4448-4bd7-8d3c-239a5e55179b
# ╠═8f24b9b2-d2b7-4308-9b64-f0c7e274463f
# ╠═3db1002f-abc3-4781-9862-2bf82a057b81
# ╠═60859f4c-a549-4851-85c8-cc1eb1a1ea9f
# ╠═652fcbda-ac03-4a90-958c-a3739b08fab0
# ╠═b4f733ed-3069-4f81-89e2-a2c069d6b25b
# ╠═09a52cce-ca36-4d1c-8fbc-38196bffc09d
# ╠═28d6e92f-cbb5-40f6-b4f1-81fdec46456d
# ╠═f663e150-2ebe-401c-a0bb-8a910476ee02
# ╠═5df72ac7-1f4d-4cdd-9dea-b2260b5197e0
# ╠═0f511fed-05f6-4970-9eba-0bc58182d91f
# ╠═444f1b65-7eab-4550-9b08-3c83a60c7f64
# ╠═268a0e38-1ec1-4fdc-a947-c65ba851e8eb
# ╠═0689dbf0-255e-4c30-a88b-2851914d19f3
# ╠═4fa96ad7-ed04-401b-a7ac-e71c24cb73fc
# ╠═a0dbf262-25c0-4d23-9b4b-1a17b20539be
# ╠═20437f49-3bff-44a4-ba86-b3a30689450c
# ╠═b4e49482-aa94-43a8-a472-7230ece557c0
# ╠═488a1cf3-6a06-49c7-93c9-bcf388ea5943
# ╠═76f712db-0a60-4518-a06c-3bee6d2aa08e
# ╠═67147ca1-2d89-44a8-9c11-353ee6cb293c
# ╠═3a15c778-3d84-4c65-929a-22f43bca517c
# ╠═388f32bc-debf-4f54-878e-377a58cd9a66
# ╠═b359a15e-440a-4849-935f-2ca7af3c263e
# ╠═aeb2b5ab-3214-44b2-8eee-039ef4e9684d
# ╠═78a85346-1d4c-4c20-8191-870ca37b04bd
# ╠═7f59cdda-709a-45e5-b6a0-53301066a6b6
# ╠═ef057b36-8339-48ff-8440-441b63e51b15
# ╠═5f60603b-3d67-4cd2-9f7a-fd4837db6c1d
# ╠═77411715-da83-4f24-b915-91a2a76d207c
# ╠═87a363c1-0eb9-4b5a-b888-0054d933de7c
# ╠═e20b0e9b-4e81-42a6-9af9-a2dbcf0b052c
# ╠═6cc6aa0c-fbdd-42a2-afd1-7a21929699e6
# ╠═8d65ec5d-758f-4afd-8408-fef03eb3b8c3
# ╠═4b926625-2d61-4326-b12c-783803b5ac99
# ╠═d8d9ed48-bd64-4a0f-9dbd-42b9115d8837
# ╠═c5b30329-c34b-45c9-92b5-fd03828d2fc1
# ╠═e92de989-f4c3-4998-9900-61dba2b79a5d
# ╠═a66a69ae-a726-4cf6-94bb-bf9b88b18efb
# ╠═23b2af75-73dd-4be0-ad41-760fcc533f50
# ╠═6fe6eef3-6a85-414e-9947-1a29e235b406
# ╠═8ee67312-0a6a-4fa4-b7c3-519b3f146df1
# ╠═37e6381a-30a4-481c-8d1c-55ccb87fb353
# ╠═1296320b-d714-4b80-87f8-1cefb1dbf868
# ╠═a86924e6-39ed-4f58-b60c-4473f6a9bb8d
# ╠═76151351-4f16-4d58-b2ae-c91dde660477
# ╠═8b886e2d-6eb0-43c1-9cbd-822b5e01e8ce
# ╠═1e3a631b-e4a8-412e-a4e1-3beeace38c62
# ╠═6d232648-2dd4-402f-8b54-e79c6608afd8
# ╠═3b3b6e04-d25c-4aa6-ad68-7466bbb6dbc3
# ╠═49e3c863-eca3-499e-828a-dca0f4039de4
# ╠═14ab4e0f-203f-4fab-9036-3696b7ef3ab8
# ╠═866c601b-9e48-4493-ba2e-39df9864141a
# ╠═ff6b783b-a2a1-43fb-b38d-b0fd967841ca
# ╠═245cc832-6d01-4367-ad8b-4f1b55b5390e
# ╠═820d1231-d71f-45a6-90e0-6d22d15156a5
# ╠═e1f9c16b-bcab-4ef5-b115-77a7a9362470
# ╠═fef0ce0e-44d6-4484-80e1-45bd5c9c7e38
# ╠═21578ccb-3943-48fd-b1fd-6237bdf4f80f
# ╠═0a3bb76a-3ef7-41f5-80ca-df935932da77
# ╠═c17a6aa4-79a7-426c-bdee-96039b800857
# ╠═b88f392c-8a1a-4acf-b3cd-c31d7a4fd627
# ╠═b3c270fb-fa77-41d4-8f3c-718f3aac6f77
# ╠═22f01bfb-5ea9-4f7c-975d-e906b8ae3563
# ╠═ce3cc1f3-6a54-47b2-a409-f71d8dcb7afb
# ╠═a1a99278-7e8e-4b4e-a795-d00d5e40465e
# ╠═99786701-3a49-4433-bb05-ab5e5fa47d1e
# ╠═ff15af23-cb50-4441-9592-1819421a6205
# ╠═64b58c58-9ce8-4e42-911d-d4f780d7c1b6
# ╠═40be7660-d642-4c48-9cbe-3396106034cc
# ╠═5109a629-ff2a-4bf2-8e86-78f30d05a41d
# ╠═ba7ce037-e348-48bc-8140-238e542b29c4
# ╠═6b058d97-d87c-442f-b938-163095b271a5
# ╠═c9a2150d-6a4f-40b3-aaa3-d659b75c57d8
# ╠═a15190b3-27ac-48e2-b5bb-d36a802b38d6
# ╠═11f55be0-b133-4522-8782-0a3e1f3fde0b
# ╠═4199ca17-5342-46cf-80db-fd512413f2cd
# ╠═0d6ea1fa-1741-4400-84bd-1e364c260741
# ╠═86b136ca-d77f-4fdf-a0c6-0d6f26d559d9
# ╠═1a0b6cb1-c981-4e4b-b94f-b96bc7843e71
# ╠═6200b397-026f-4484-9680-025bff7e73e1
# ╠═5308d425-1862-42c6-a305-4026876576ac
# ╠═11b450ad-d234-4964-a953-c184d9a12098
# ╠═1bd7bb23-cae3-4314-896e-72eb0b40c514
# ╠═47d3d946-3d6a-475d-b9dc-1e89e47de8c0
# ╠═c25e89a0-be69-4613-be6b-aabdec176dec
# ╠═72e46d50-99a9-4c97-90cf-ea4e682a21ae
# ╠═573fafea-56ed-48e8-88ec-df36f244c8f5
# ╠═639e791f-01e6-4481-8df9-0a1fa2482d1b
# ╠═6a67111e-9224-4459-b89b-f374a08d0be6
# ╠═21072c0c-e840-47a4-ba7a-a783aa7a089c
# ╠═1f409f70-fee6-414b-8c58-cd71d2a8b5a3
# ╠═f25fccd1-7478-4b92-bf82-b7f3a84dd930
# ╠═38ee2580-a7a8-4dd4-b3ca-281d97a65edc
# ╠═250622de-03a0-4675-a91f-9cdb059fcca7
# ╠═554abb12-c1e6-4c90-aeaf-f4c8d97379a3
# ╠═6a742c0c-a6f4-45b8-b5a0-f8c9f842773b
# ╠═7b99a92b-699e-42d3-9e0b-60cdefc9ef0f
# ╠═ab0549c7-21a3-4028-8db2-2718d25ef5a6
# ╠═8d0c5648-4ba5-42ae-ab36-25eb69b88649
# ╠═3b6865f9-f8ab-4f77-ad81-b654ef3de5ae
# ╠═e9b8f83b-beae-476b-a9be-9a6c56632f06
# ╠═cd5cc619-d400-4266-9094-a0a83f58fbf0
# ╠═7c6489db-35ec-40de-b0e0-ccf93f0a90ee
# ╠═e425cdba-1cc9-4073-8bd1-e009bf32bb04
# ╠═6619fb02-1afe-4350-b8cf-2ca595c3e6a0
# ╠═1125bd37-fb19-45df-860d-f86fbc08d823
# ╠═b1bdffc4-8f7c-4714-a7be-145ecf4ad3b8
# ╠═0dfe1b52-04cf-4dd9-885d-74c8e0cac799
# ╠═992a775a-d4ab-4d73-a499-459d9fa3e776
# ╠═1b235fca-23ec-46b3-ba93-33508582bef0
# ╠═9fb079ba-8eea-4fca-a170-e648717af5f4
# ╠═f4b48aef-a841-4acc-a3a1-c419a135d647
# ╠═364db8a0-bd2d-49a5-bffc-de56814e5888
# ╠═d1918575-46e4-4876-a94c-3e232b48b4f2
# ╠═d997cfbb-a5dd-4728-b0a7-9a6f2ddce42f
# ╠═57424fc3-2161-4772-baec-a23e82e749c4
# ╠═efa82d81-4fdd-455d-acc0-9a2147a5de1b
# ╠═0f6d5f54-ba8f-4ff0-ae11-a4703bc3a5ab
# ╠═0dfc6f69-a1c7-432e-8d35-65e0b9df8d73
# ╠═a9488b85-218e-45ea-896d-d849f485e958
# ╠═da9be907-3b32-4bea-8c8b-94ababcd2dc5
# ╠═13187e58-9a5e-4313-84c3-18936f0a0aef
# ╠═a5d36503-0a65-4e5a-b6b2-230f459d838d
# ╠═f25d30ae-f2ce-461d-8e2b-cba82f61c031
# ╠═be18640e-1d7b-4c50-b3df-bfc6ebf36089
# ╠═7f2bd8ab-fd0d-4764-9d71-a39b495ef1e3
# ╠═55d074c4-2128-4984-bb04-260e617066d4
# ╠═276e5bb4-ae8f-4666-9abd-59a601fe96a8
# ╠═8c1c9824-9bba-4104-92f6-35f0482299f4
# ╠═2e5292ee-c313-41af-8ffe-766d82769ece
# ╠═eac6459d-88a1-4c92-98a1-171667fb62bc
# ╠═388dd1f4-39fd-4d8f-a473-e37abce5e6a1
# ╠═0250c6a0-1890-4011-b1e3-fbc43516b0d3
# ╠═965d15a2-6027-4277-9793-767301770469
# ╠═666b607b-19af-44bf-9e30-52f9c0ab248b
# ╠═47c63f92-f0ed-494c-9e9a-14e7cc4c6e44
# ╠═6d5db40b-23ad-44db-8442-2a0f8ab6002c
# ╠═6555ad08-6d83-4745-93d1-d016dd40e9d7
# ╠═e227dd5b-facf-47f4-a697-bc27bed725a9
# ╠═bc9a8b94-d96d-42d1-986b-af74d9d66c84
# ╠═87c51191-400c-4a05-b8ea-bb9fa5292d9e
# ╠═61842353-23ee-454b-9aae-7c5451d094b4
# ╠═a1c4bbc4-45af-4cd8-b02c-d59b94ea1cb2
# ╠═a447413e-939b-4c47-84d9-00a8f0bdb197
# ╠═74febb89-8545-4759-b4e6-95410b1a7117
# ╠═cd1f29ed-c476-4603-b9d3-fe700cc070b0
# ╠═dd4fdb1b-85bf-4326-a99b-7fa4a3ac3cbe
# ╠═3e3ad40f-4a65-469e-af7e-0410a4918d21
# ╠═182464ed-24ef-4abf-b98a-8b0655788b06
# ╠═b69e36a6-62b1-4dfd-8594-bbd942e64f96
# ╠═de4b900b-01b4-44cb-b1e8-16c580de2b74
# ╠═7451dbee-0353-467b-ad97-666c1c520819
# ╠═9adfcb62-50bf-4d78-8119-746c1580a92d
# ╠═c2f1ed3b-9b65-44db-b8ba-1cdeabb14955
# ╠═bd569a04-5aea-4081-9b0a-45690daba964
# ╠═cfb63469-12f1-47ae-82a0-660be26051d8
# ╠═c423d947-1795-4ea3-9c23-9d5558cb581f
# ╠═7708ce82-755d-4618-9469-f27918656474
# ╠═e06e7bb2-d372-404b-897e-6bf447eab874
# ╠═bb7fc26f-7e86-4c45-ac77-4b16b04e266d
# ╠═fabc0cb0-d06f-4071-8041-b225ab028984
# ╠═e3fd3e8e-37b6-4a79-8a77-a5bece3f6af7
# ╠═99aea4e7-2063-4986-ae99-83a369cf32f6
# ╠═2fcc54ae-5ff8-4652-8935-b7cf7baa1e97
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
