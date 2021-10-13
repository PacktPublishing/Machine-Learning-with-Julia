### A Pluto.jl notebook ###
# v0.16.1

using Markdown
using InteractiveUtils

# ╔═╡ c9994475-bef9-4557-b774-e20bd99c049d
using DataFrames, Statistics, CategoricalArrays, DataFramesMeta

# ╔═╡ aac765bf-9ccd-4442-beea-38a765c59d0a
using CSV, SQLite, Query, Tables

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
df = DataFrame((a=[7, 7], b=[3, 4]))

# ╔═╡ 2dfeea25-0a7d-477b-8f0b-238cb5ac996f
length(df[1,:]) # get number of elements in the DataFrameRow

# ╔═╡ d4e72dfe-88cf-455c-8619-fa337d8ad198
df[1, :]

# ╔═╡ 4276b4fc-83b2-45bb-a114-af205d47041b
gf = groupby(df, :a)[1]

# ╔═╡ c5337a2c-44ec-4813-8430-b3505b6488e1
ByRow(+)([1, 2, 3, 4, 5], [2, 4, 5, 6, 7]) # implements the function row-wise

# ╔═╡ e2faa9b1-9ae0-4ef8-a235-5bc67f997f23
AsTable((Name = "Nabs", Age = 23))

# ╔═╡ 88224c4a-2e92-48be-a329-9a7e5b449d57
DataFrame([7 1 5; 9 10 11], :auto) # here columns x1, x2, x3, .. are auto generated

# ╔═╡ d461a50d-bab2-4f46-b0d6-56568439b2e9
eachrow(df)[2]

# ╔═╡ d8e290ee-42ee-42b9-b098-254e72af8638
eachcol(df)

# ╔═╡ ff6bad5e-7373-4c2e-a69c-e4dc4ad4b620
similar(df, 4) # has same number of columns as the parent dataframe but with specified numer of rows

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

# ╔═╡ 317347d7-54cd-4a01-bf61-6154e7a9e63e
#=
Other formats from which a Julian DataFrame can be created and written to are:  
1. Arrow.jl
2. Feather.jl
3. Avro.jl
4. JSONTables.jl
5. Parquet.jl (Parquet)
6. StatFiles.jl (Stata, SPSS, SAS)
7. XLSX.jl
=#
# You can also use DelimitedFiles.jl for creating DataFrame

# ╔═╡ 50e83a4f-68c6-45ff-bc58-fb24a1fdda83
# using the CSV read() function

# ╔═╡ b5352a9f-385f-4e1a-9bd4-c43a95681b9e
df3 = CSV.read("gdp.csv", DataFrame) # Here DataFrame is passed as an object

# ╔═╡ 68a29a3d-040b-49d9-8453-0ec29b9ea91f
isapprox.(df2, df3) # this won't work because the columns have String type data

# ╔═╡ 87cb09b7-05d5-4863-8ec0-015ca5755cad
isapprox.(DataFrame(a=rand(10), b=rand(10)), DataFrame(a=rand(10), b=rand(10))) #broadcasted over all values over columns

# ╔═╡ 50b0a355-ebf8-4a5f-89ce-132724abf382
isapprox(DataFrame(a=rand(10), b=rand(10)), DataFrame(a=rand(10), b=rand(10)))

# ╔═╡ 90f197cc-4fbd-4dc0-b7d0-1e8d37a592a1
values(df1)

# ╔═╡ 44ba67f4-b846-4f8f-afd2-40f9bb6ee93c
pairs(df1[!,:Period])

# ╔═╡ 2a147ec5-302b-4ef7-a25d-50a6a40916a6
# create DataFrame column by column

# ╔═╡ 322d07a8-95dc-490c-be8b-68b2cf332c19
b = DataFrame()

# ╔═╡ 946a5035-4586-442d-be37-b714ef171d99
b.A = 1:20

# ╔═╡ ed786d21-3bbf-4786-8ce1-3853de366a83
b.B = repeat(["M", "F"], 10)

# ╔═╡ 9470fd0e-286d-4ad4-bb5f-d76916a84d0e
# create DataFrame row by row

# ╔═╡ 977c1861-f6ef-4505-94e6-cdf064679487
push!(b, [21, "M"])

# ╔═╡ b74f2b45-dcd8-4cc8-9043-71b1388e475a
push!(b, Dict(:A => 22, :B => "F"))

# ╔═╡ bd7ccba5-3eea-4fa9-ac1b-4a3f67760b18
# DataFrames supports Tables.jl which is the Julian interface to interact with tabular data

# ╔═╡ 6a3c345c-4ea6-4b3f-9eb4-44779863d2d8
CSV.write("df2csv.csv", b) # write to a CSV file

# ╔═╡ 7d40b765-b7f7-400d-9269-6906ffe0d922
SQLite.load!(b, SQLite.DB(), "df2sqlite_table") # in memory sqlite database

# ╔═╡ 9a420cda-0e7b-4372-b5c5-bd8fd6319d42
b1 = b |> @map({_.A, _.B}) |> DataFrame # transform df through Query.jl

# ╔═╡ f17ec4dc-8e3d-4381-9b29-5ef755592036
Tables.rowtable(b) # use NamedTuples for creating DataFrame

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

# ╔═╡ 9a1a83ed-2801-4f21-8a99-3a4e7ec70a5e
rename(gdp, :UNITS => :UNITS_STATS)

# ╔═╡ 499dc896-5c55-4bee-a9e3-e006c495c67d
groupiegdp = groupby(gdp, [:Period, :Data_value])

# ╔═╡ 45060fd5-db50-4222-8e0d-3d7bb8be5b08
get(groupiegdp, (UNITS="Percent",), nothing)

# ╔═╡ ec2e9079-f447-4da5-ac08-b63b7cf4d4a4
groupcols(groupiegdp)

# ╔═╡ e027e8fd-a918-4a64-a88b-54fc7d5ce4b4
groupindices(groupiegdp)

# ╔═╡ ffa1c8de-b952-4718-bcc5-5c65fe721dc8
keys(groupiegdp)

# ╔═╡ 2a5f7dea-5ae4-4da7-906f-0b9810e9cea0
valuecols(groupiegdp)

# ╔═╡ 311d401a-8778-4362-b2b3-01df66b37142
parent(groupiegdp)

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

# ╔═╡ 08fa8033-ab7b-483d-9500-6c32c4f243c3
ndims(gdp)

# ╔═╡ 98d20964-0a16-43d4-aadc-e56aec601213
rownumber(gdp[2,:])

# ╔═╡ 75fd60e7-d96d-4edb-9766-ff41ef600805
parentindices(gdp)

# ╔═╡ f4408b75-8a25-42e7-917b-42f9c0bfff2e
parent(gdp)

# ╔═╡ 3093d613-5109-4051-b8f6-935b842246a6
describe(gdp, cols=4:7)

# ╔═╡ 20270e3d-9e84-4ff5-811c-47e80d5459d3
show(stdout, MIME("text/latex"), gdp) # output is printed in terminal

# ╔═╡ 0b86cc10-63cb-42a2-9812-1384c097ae35
show(stdout, MIME("text/csv"), gdp) # output is printed in terminal

# ╔═╡ 626c4687-0719-4651-bb3b-1d638d936b7e
show(stdout, MIME("text/html"), describe(gdp)) # output is printed in terminal

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
view(gdp, 77:300, :) # or else use macro @view gdp[end:-1:1, [1, 4]]. No new objects is created while using view, hence gives better performance while you are trying to peek into the data.

# ╔═╡ c901457f-312b-4dee-98ed-b81493f56030
@timev gdp[1:end-1, 1:end-1]

# ╔═╡ b1a61755-8791-48e6-90dd-cb6023034395
@timev @view gdp[1:end-1, 1:end-1]

# ╔═╡ 4e6fe563-2c1b-42dc-a83e-3c4207e447d2
# view creates a mapping of indices from the view to the indices of the parent. As you can see in the chapter, view uses less memory allocations and takes less time than accessing dataframe using '[]' operator because no new object is created and points to the same memory location as of the parent. You can update the dataset using view and '[]' operator.

# ╔═╡ 107f0e6d-a9a1-4414-bf45-b0b0b1c57c67
# Broadcasting

# ╔═╡ ee04f0e0-3a93-4adf-9b90-83987e1f1d1e
# As opposed to R, broadcasting in Julia is similar to that of Python. We use '.' dot operator.

# ╔═╡ e6da06de-fc3e-4a89-868f-62dc47490126
 s = [24, 54.0, 345, 098765, 43, 231.4, 497.23]

# ╔═╡ a2efce21-5f2a-43b9-9e1b-1861220617a7
s[3:7] .= 0

# ╔═╡ ed5802e5-65a1-4e8c-a633-613a07a3bfec
# ':' operator does the broadcasting in place. '!' operator creates a new vector instead of replacing the old one.

# ╔═╡ c0634c82-f36c-4bfa-8284-564adc309932
insertcols!(df1, 1, :Country => "India") # this is called pseudo-broadcasting. It inserts columns in arbitrary places.

# ╔═╡ 3aeeeb61-e004-4317-81c7-aa37d7ade55e
# Selectors in DataFrame

# ╔═╡ ee03f50a-3def-44aa-b14d-c4b5da7a9a63
gdp[:, Not(:Period)]

# ╔═╡ 72dfa3c2-ec92-4c97-98a7-525964218356
gdp[:, Between(:Data_value, :MAGNTUDE)]

# ╔═╡ 6d699f5b-0ac0-40b9-a601-ec0205131cdd
gdp[:, Cols("Period", Between("Data_value", "MAGNTUDE"))]

# ╔═╡ 08c1fbea-ad4f-414d-a942-6445a5fc8f62
# You can use Regex to select columns too. Here, we select columns having number "6" and not the 3rd column.
gdp[Not(3), r"6"]

# ╔═╡ 2c1e30ce-f3fa-4a67-b4f3-0587f466ec00
sample = DataFrame(x = [("a", "z"), ("b", "y"), ("c","x")])

# ╔═╡ 12cb9501-d815-45ef-84b2-2886e180a90c
sample1 = DataFrame(x = [("1", "10"), ("2", "9"), ("3","8")])

# ╔═╡ ecc4cd83-cc73-4358-8df5-25d566b36185
flatten(sample, :x)

# ╔═╡ cbb9f819-2645-4f7d-9c61-537041bd5466
hcat(sample, sample1, makeunique=true)

# ╔═╡ 263b9a78-34bb-44a5-bf76-b5d402a4579e
vcat(sample, sample1)

# ╔═╡ 52cf77af-1fee-4b47-8f02-5c94e060a401
reduce(vcat, [sample, sample1])

# ╔═╡ 50f35a40-8fee-4a3f-b3a9-b344a8c4253e
repeat(sample, inner = 3, outer = 5)

# ╔═╡ 6e8eafa8-6854-4b4b-8a02-a82f08314505
# Transformation functions

# ╔═╡ 81ecd06e-8c13-4dc0-81c9-ed575b8303bb
gdp

# ╔═╡ 95cf6d4e-a89b-40c1-a6b0-2f0692c27651
append!(gdp, gdp)

# ╔═╡ eccb8cec-d709-4682-bc34-2867402a6cfc
combine(gdp, :Data_value => mean => :mean_data_value) # this aggregates data and makes a copy

# ╔═╡ 86bbd468-ecc4-4026-9dd4-5d8f2b9d50dc
select(gdp, :Data_value => mean => :mean_data_value) 
# this broadcasted the result of the mean
# in mean missing takes precedence

# ╔═╡ e69776d2-3640-4c9f-aef2-d30a94dee390
transform(gdp, :Data_value => maximum) # inserts a column with the maximum value of the dataframe


# ╔═╡ 8ba893b5-97fc-4a41-9dc5-67f9c11708bc
transform(gdp, :Subject => :Group, :Group => :Subject) # transform retains all columns present in parent dataframe unlike select

# ╔═╡ acec4361-d271-41dd-b6cf-4571eae16406
select(gdp, :Period, :Data_value, [:Period, :Data_value] => (-) => :resulting_vector) # this assumes both the columns to be consecutive and calculates the specified operation. Only +, - works. select always makes a copy of the columns. You can change this with argument copycols set to false.

# ╔═╡ 38fb2132-8f03-4b5c-aa76-a265bac69497
# Joins

# ╔═╡ 454d0957-0cdc-4490-bbdc-8409b07cddcd
#=
Julia supports innerjoin, leftjoin, rightjoin, outerjoin, semijoin, antijoin and crossjoin.
=#

# ╔═╡ ff622ae3-b4ea-4b0c-90cb-a6d1cd7c857e
pupil = DataFrame(Rno = [40, 50, 60, 80, 90, 100, 130], Name = ["P1", "P2", "P3", "P4", "P5", "P6", "P7"])

# ╔═╡ c49773c7-cb73-437c-abb2-3e05e9b3c4f7
mark = DataFrame(Rno = [20, 30, 60, 70, 90, 110, 120], Marks = [25, 45, 63, 72, 64, 87, 36])

# ╔═╡ cd93d1b5-b587-4dc3-ae93-de0489163c3a
innerjoin(pupil, mark, on = :Rno)

# ╔═╡ 96202339-68d6-4d8b-af6e-f56e4b6b282d
leftjoin(pupil, mark, on = :Rno)

# ╔═╡ fd9351e2-e0b8-4042-b2d2-0b8cddf76b8a
rightjoin(pupil, mark, on = :Rno)

# ╔═╡ efdf00c9-f0b0-4d9b-b940-e0f4168220ac
outerjoin(pupil, mark, on = :Rno)

# ╔═╡ c1ad8951-554a-4f9c-ac02-2b86c69210e9
semijoin(pupil, mark, on = :Rno)

# ╔═╡ 005f08fc-15b8-4927-bf4f-6f656bd7c509
antijoin(pupil, mark, on = :Rno)

# ╔═╡ 0b81cbeb-e441-4ff7-8586-4aaaa14a5204
crossjoin(pupil, mark, makeunique = true)

# ╔═╡ 85c381d1-aa5b-4e36-b764-4f2c08056723
new_pupil = DataFrame(Rno = [40, 50, 60, 80, 90, 100, 130], Name = ["P1", "P2", "P3", "P4", "P5", "P6", "P7"])

# ╔═╡ bdab1a2a-e3e9-4dd6-ba5a-3f1cbd430e9a
new_mark = DataFrame(ID = [20, 30, 60, 70, 90, 110, 120], Marks = [25, 45, 63, 72, 64, 87, 36])

# ╔═╡ d348eb2c-ce88-4813-9fdd-dbb9f6263c79
innerjoin(new_pupil, new_mark, on = :Rno => :ID) # if you have two columns conveying the same meaning but with differing names use on argument.

# ╔═╡ f66dca42-73e6-4ed9-be87-8092f45f75ae
outerjoin(new_pupil, new_mark, on = :Rno => :ID)

# ╔═╡ 87c933d0-d56f-41ec-9740-42da3aea7b02
outerjoin(pupil, mark, on=:Rno, validate=(true, true), source=:source) # for the two columns to be equal according to `isequal()`, an argument `validate` is introduced

# ╔═╡ adef617a-8b1f-4198-ba22-95c2fc23e487
# Grouping

# ╔═╡ 7d8430ce-3b06-4007-a091-dd00ebe5a4bd
grby = groupby(gdp, :Period)

# ╔═╡ 46f31f61-afaa-4788-8f44-b83face4b005
combine(gdp, :Period => mean)

# ╔═╡ cb438dec-931a-4856-91ad-809d9d4d9106
# Reshaping

# ╔═╡ 490769ee-72b2-46cd-aa88-e5b3bfe2ca9e
stack(gdp, 1:4) # convert from landscape to portrait format

# ╔═╡ 6310d056-f97b-444e-b257-3b22774f7e86
stack(gdp, [:MAGNTUDE, :UNITS], :Subject) # the 3rd argument shows which columsn are repeated

# ╔═╡ e946a789-e9e1-4f46-b7b6-d278c0d6234c
unstack(stack(gdp, Not(:Subject)), allowduplicates=true)

# ╔═╡ bcae0cbd-d30f-458a-bc74-e969dab36ed1
permutedims(b, 2, makeunique=true)

# ╔═╡ 783edc23-96fe-4484-bef0-7666668171ac
# Sorting

# ╔═╡ a63091de-654b-43fa-93ab-466fb7ad7f38
sort!(gdp)

# ╔═╡ 5e351fca-85ea-4e52-b607-e693deac1719
sort!(gdp, rev = true)

# ╔═╡ 64d4462f-f8fd-4186-9d48-dffd76c12fe6
sort!(gdp, [:Data_value, :MAGNTUDE])

# ╔═╡ 38a542dc-eee3-45b5-a52f-e342af3da728
sort!(gdp, [order(:Period, by=length), order(:Data_value, rev=true)]) # specify ordering for a particular set of columns

# ╔═╡ e2518ebc-0bfe-4ce4-9775-cd2c5abaf201
issorted(gdp)

# ╔═╡ 49c607c2-c386-4ba9-817b-c80317c0c51f
sortperm(gdp, [:Data_value, :MAGNTUDE])

# ╔═╡ 3bf66bee-e84b-4293-83f0-b5af13a3f3eb


# ╔═╡ c2d3f70e-19ef-4e59-9d22-5728a1e0f0e7
# Filtering

# ╔═╡ ff666cf9-42dc-4dfc-88bc-6ccd5f1065d5
delete!(gdp, [5, 7, 9]) # indices must be unique and sorted

# ╔═╡ 222b9658-7aba-426a-a5bd-42dee53f4365
empty(df) # clear all values from the rows

# ╔═╡ 46253de4-245c-449f-9144-5fbe0fe52af1
unique(df1)

# ╔═╡ 99a8113d-19c3-484c-a589-d75174b27422
subset(df, :b => x -> x .> 3)

# ╔═╡ adb5bf96-3f83-41ac-bfb0-2e2e1ee2e8b6
filter!(row -> row.b > 3, df)

# ╔═╡ 362bf8c3-e5d4-4631-849e-9f1af5264453
only(df)

# ╔═╡ 79a0555b-3815-4a8a-ad82-297bb0721c34
nonunique(df1)

# ╔═╡ 4ac3df0d-cf63-4cab-8c7c-6ce37a3589b2
# Handling missing values

# ╔═╡ 3845701a-4d36-4b40-a5e9-df3b3578c7a5
allowmissing!(df2) # The DataType has changed for each column.

# ╔═╡ 38f77f4d-da45-4ebf-9916-a3ddb03fb39e
disallowmissing!(DataFrame(x=Union{Int, Missing}[7, 9, 7, 6, 53, missing, 3, 2, 56, missing]), error=false)

# ╔═╡ 17536f1d-bbb0-46d9-91a6-e094b749ec9e
dropmissing!(DataFrame(x=Union{Int, Missing}[7, 9, 7, 6, 53, missing, 3, 2, 56, missing]))

# ╔═╡ 9eeb9b8a-c943-421c-a414-7bd7069bbcae
completecases(DataFrame(x=Union{Int, Missing}[7, 9, 7, 6, 53, missing, 3, 2, 56, missing]))

# ╔═╡ 374a0805-1ed4-4eef-bab7-cc4da4659a72
# Categorical Data

# ╔═╡ 1dd794a3-61c0-4f27-af0d-89bfdc973bdb
dat = CategoricalArray(repeat(["M", "F", missing], 3))

# ╔═╡ d9a58858-2bb1-44b3-a4c6-30b5d62936c4
levels(dat)

# ╔═╡ fe58c5a4-8193-440d-be36-ac989017dc42
levels!(dat, ["F", "M"]) # changes the order of appearance

# ╔═╡ 4b158c96-0273-46f1-b6fe-c75fb0974dae
sort(dat)

# ╔═╡ 371e9b4c-1a94-42a9-b4ee-a837bd005a7a
dat_new = compress(dat) # since Categorical Arrays can store upto \2^32 levels. compress() is used to lessen the memory space.

# ╔═╡ fd45ccc8-7d10-4081-b681-ea398248b495
dat2 = categorical(repeat(["N", "A", "P"], 3), ordered=true)

# ╔═╡ 05e57f17-784e-49e5-815e-f7d94aea5ab8
isordered(dat2)

# ╔═╡ 466b9320-6fe1-41df-9dae-7c90a12fca5d
dat == dat2

# ╔═╡ 8ae1afae-ea67-49d9-be53-7909885fb083
# Missing Data
# We have gone through missing datatype previously. Here we will see just one examples of how to convert any missing data to have a numeric value in Julia

# ╔═╡ 91559ca4-aa63-409c-a9da-c02726121bee
missin = [8, 30, 41, missing]

# ╔═╡ 27cdd96d-774e-4afb-b680-4f3f52a21e94
coalesce.(missin, 0)

# ╔═╡ f23449ba-ad22-4f75-a896-3aa8f94a3b74
# Data Manipulation Frameworks

# ╔═╡ 0d499e42-4467-4384-a5f9-193f259fec60
# The main part of data analysis work is data manipulation. In Julia, we can use DataFramesMeta.jl and Query.jl to manipulate DataFrames which is similar to frameworks in Python/R.

# ╔═╡ 6b3dc5c1-7c61-47fc-ae1b-03f4116de245
@linq gdp |>
           where(:Period .> 2000) |>
           select(units="Percent", :Series_reference) # linq macro helps to perform a series of transformations of the DataFrame. You can use all the split-apply-combine methods here within linq macro.

# ╔═╡ 27d5e59d-e9a0-49b3-805b-1637a5e9d078
@from i in gdp begin
            @where i.Period > 2000 && i.Data_value > 0
            @select i.Series_reference
            @collect
       end
# Query also helps you to manipulate the dataframe

# ╔═╡ ca1077c7-6bfe-406f-95d5-1686328022e2


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
CategoricalArrays = "324d7699-5711-5eae-9e2f-1d82baa6b597"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
DataFramesMeta = "1313f7d8-7da2-5740-9ea0-a2ca25f37964"
Downloads = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
Query = "1a8c2f83-1ff3-5112-b086-8aa67b057ba1"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
SQLite = "0aa819cd-b072-5ff4-a722-6bc24af294d9"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
Tables = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"

[compat]
BenchmarkTools = "~1.1.4"
CSV = "~0.8.5"
CategoricalArrays = "~0.10.0"
DataFrames = "~1.2.2"
DataFramesMeta = "~0.9.0"
Query = "~1.0.0"
SQLite = "~1.1.4"
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

[[BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Statistics", "UUIDs"]
git-tree-sha1 = "42ac5e523869a84eac9669eaceed9e4aa0e1587b"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.1.4"

[[BinaryProvider]]
deps = ["Libdl", "Logging", "SHA"]
git-tree-sha1 = "ecdec412a9abc8db54c0efc5548c64dfce072058"
uuid = "b99e7846-7c00-51b0-8f62-c81ae34c0232"
version = "0.5.10"

[[CSV]]
deps = ["Dates", "Mmap", "Parsers", "PooledArrays", "SentinelArrays", "Tables", "Unicode"]
git-tree-sha1 = "b83aa3f513be680454437a0eee21001607e5d983"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.8.5"

[[CategoricalArrays]]
deps = ["DataAPI", "Future", "JSON", "Missings", "Printf", "RecipesBase", "Statistics", "StructTypes", "Unicode"]
git-tree-sha1 = "1562002780515d2573a4fb0c3715e4e57481075e"
uuid = "324d7699-5711-5eae-9e2f-1d82baa6b597"
version = "0.10.0"

[[Chain]]
git-tree-sha1 = "cac464e71767e8a04ceee82a889ca56502795705"
uuid = "8be319e6-bccf-4806-a6f7-6fae938471bc"
version = "0.4.8"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "727e463cfebd0c7b999bbf3e9e7e16f254b94193"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.34.0"

[[Crayons]]
git-tree-sha1 = "3f71217b538d7aaee0b69ab47d9b7724ca8afa0d"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.0.4"

[[DBInterface]]
git-tree-sha1 = "d3e9099ef8d63b180a671a35552f93a1e0250cbb"
uuid = "a10d1c49-ce27-4219-8d33-6db1a4562965"
version = "2.4.1"

[[DataAPI]]
git-tree-sha1 = "ee400abb2298bd13bfc3df1c412ed228061a2385"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.7.0"

[[DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Reexport", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "d785f42445b63fc86caa08bb9a9351008be9b765"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.2.2"

[[DataFramesMeta]]
deps = ["Chain", "DataFrames", "MacroTools", "Reexport"]
git-tree-sha1 = "807e984bf12084b39d99bb27e27ad45bf111d3a1"
uuid = "1313f7d8-7da2-5740-9ea0-a2ca25f37964"
version = "0.9.0"

[[DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "7d9d316f04214f7efdbb6398d545446e246eff02"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.10"

[[DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[DataValues]]
deps = ["DataValueInterfaces", "Dates"]
git-tree-sha1 = "d88a19299eba280a6d062e135a43f00323ae70bf"
uuid = "e7dc6d0d-1eca-5fa6-8ad6-5aecde8b7ea5"
version = "0.4.13"

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

[[IterableTables]]
deps = ["DataValues", "IteratorInterfaceExtensions", "Requires", "TableTraits", "TableTraitsUtils"]
git-tree-sha1 = "70300b876b2cebde43ebc0df42bc8c94a144e1b4"
uuid = "1c8ee90f-4401-5389-894e-7a04a3dc0f4d"
version = "1.0.0"

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

[[MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "0fb723cd8c45858c22169b2e42269e53271a6df7"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.7"

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

[[Query]]
deps = ["DataValues", "IterableTables", "MacroTools", "QueryOperators", "Statistics"]
git-tree-sha1 = "a66aa7ca6f5c29f0e303ccef5c8bd55067df9bbe"
uuid = "1a8c2f83-1ff3-5112-b086-8aa67b057ba1"
version = "1.0.0"

[[QueryOperators]]
deps = ["DataStructures", "DataValues", "IteratorInterfaceExtensions", "TableShowUtils"]
git-tree-sha1 = "911c64c204e7ecabfd1872eb93c49b4e7c701f02"
uuid = "2aef5ad7-51ca-5a8f-8e88-e75cf067b44b"
version = "0.9.3"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[RecipesBase]]
git-tree-sha1 = "44a75aa7a527910ee3d1751d1f0e4148698add9e"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.1.2"

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "4036a3bd08ac7e968e27c203d45f5fff15020621"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.1.3"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[SQLite]]
deps = ["BinaryProvider", "DBInterface", "Dates", "Libdl", "Random", "SQLite_jll", "Serialization", "Tables", "Test", "WeakRefStrings"]
git-tree-sha1 = "97261d38a26415048ce87f49a7a20902aa047836"
uuid = "0aa819cd-b072-5ff4-a722-6bc24af294d9"
version = "1.1.4"

[[SQLite_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "9a0e24b81e3ce02c4b2eb855476467c7b93b8a8f"
uuid = "76ed43ae-9a5d-5a62-8c75-30186b810ce8"
version = "3.36.0+0"

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

[[StructTypes]]
deps = ["Dates", "UUIDs"]
git-tree-sha1 = "8445bf99a36d703a09c601f9a57e2f83000ef2ae"
uuid = "856f2bd8-1eba-4b0a-8007-ebc267875bd4"
version = "1.7.3"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[TableShowUtils]]
deps = ["DataValues", "Dates", "JSON", "Markdown", "Test"]
git-tree-sha1 = "14c54e1e96431fb87f0d2f5983f090f1b9d06457"
uuid = "5e66a065-1f0a-5976-b372-e0b8c017ca10"
version = "0.2.5"

[[TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[TableTraitsUtils]]
deps = ["DataValues", "IteratorInterfaceExtensions", "Missings", "TableTraits"]
git-tree-sha1 = "78fecfe140d7abb480b53a44f3f85b6aa373c293"
uuid = "382cd787-c1b6-5bf2-a167-d5b971a19bda"
version = "1.0.2"

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

[[WeakRefStrings]]
deps = ["DataAPI", "Random", "Test"]
git-tree-sha1 = "28807f85197eaad3cbd2330386fac1dcb9e7e11d"
uuid = "ea10d353-3f73-51f8-a26c-33c1cb351aa5"
version = "0.6.2"

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
# ╠═2dfeea25-0a7d-477b-8f0b-238cb5ac996f
# ╠═d4e72dfe-88cf-455c-8619-fa337d8ad198
# ╠═4276b4fc-83b2-45bb-a114-af205d47041b
# ╠═c5337a2c-44ec-4813-8430-b3505b6488e1
# ╠═e2faa9b1-9ae0-4ef8-a235-5bc67f997f23
# ╠═88224c4a-2e92-48be-a329-9a7e5b449d57
# ╠═d461a50d-bab2-4f46-b0d6-56568439b2e9
# ╠═d8e290ee-42ee-42b9-b098-254e72af8638
# ╠═ff6bad5e-7373-4c2e-a69c-e4dc4ad4b620
# ╠═386f80f7-10d1-4075-897d-af48ff2f5eda
# ╠═46871146-e192-4d1a-944b-eb06fa3d44ec
# ╠═f24fb0a1-2a39-4a0d-aa7c-f60856307f6d
# ╠═20e1013b-f753-4e21-a0f6-5afa50341811
# ╠═92083de8-cb06-48c8-bca3-14a84c80587f
# ╠═9a12e206-a900-40e1-ad28-348dfba3b840
# ╠═286dff3d-d926-43b2-abcd-0c9c68fb978c
# ╠═317347d7-54cd-4a01-bf61-6154e7a9e63e
# ╠═50e83a4f-68c6-45ff-bc58-fb24a1fdda83
# ╠═b5352a9f-385f-4e1a-9bd4-c43a95681b9e
# ╠═68a29a3d-040b-49d9-8453-0ec29b9ea91f
# ╠═87cb09b7-05d5-4863-8ec0-015ca5755cad
# ╠═50b0a355-ebf8-4a5f-89ce-132724abf382
# ╠═90f197cc-4fbd-4dc0-b7d0-1e8d37a592a1
# ╠═44ba67f4-b846-4f8f-afd2-40f9bb6ee93c
# ╠═2a147ec5-302b-4ef7-a25d-50a6a40916a6
# ╠═322d07a8-95dc-490c-be8b-68b2cf332c19
# ╠═946a5035-4586-442d-be37-b714ef171d99
# ╠═ed786d21-3bbf-4786-8ce1-3853de366a83
# ╠═9470fd0e-286d-4ad4-bb5f-d76916a84d0e
# ╠═977c1861-f6ef-4505-94e6-cdf064679487
# ╠═b74f2b45-dcd8-4cc8-9043-71b1388e475a
# ╠═bd7ccba5-3eea-4fa9-ac1b-4a3f67760b18
# ╠═6a3c345c-4ea6-4b3f-9eb4-44779863d2d8
# ╠═7d40b765-b7f7-400d-9269-6906ffe0d922
# ╠═9a420cda-0e7b-4372-b5c5-bd8fd6319d42
# ╠═f17ec4dc-8e3d-4381-9b29-5ef755592036
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
# ╠═9a1a83ed-2801-4f21-8a99-3a4e7ec70a5e
# ╠═499dc896-5c55-4bee-a9e3-e006c495c67d
# ╠═45060fd5-db50-4222-8e0d-3d7bb8be5b08
# ╠═ec2e9079-f447-4da5-ac08-b63b7cf4d4a4
# ╠═e027e8fd-a918-4a64-a88b-54fc7d5ce4b4
# ╠═ffa1c8de-b952-4718-bcc5-5c65fe721dc8
# ╠═2a5f7dea-5ae4-4da7-906f-0b9810e9cea0
# ╠═311d401a-8778-4362-b2b3-01df66b37142
# ╠═28ea219e-fbf7-477a-b245-95fc7397b256
# ╠═528af444-1692-433f-9800-763cb1da56d3
# ╠═764e6a45-fe29-47a8-914a-21c545887c3c
# ╠═bb22078d-fe42-4f4c-8b0b-0b4cb1f71469
# ╠═bf4cbe82-43c8-4f5b-bffb-9a0e7ffa8d93
# ╠═08fa8033-ab7b-483d-9500-6c32c4f243c3
# ╠═98d20964-0a16-43d4-aadc-e56aec601213
# ╠═75fd60e7-d96d-4edb-9766-ff41ef600805
# ╠═f4408b75-8a25-42e7-917b-42f9c0bfff2e
# ╠═3093d613-5109-4051-b8f6-935b842246a6
# ╠═20270e3d-9e84-4ff5-811c-47e80d5459d3
# ╠═0b86cc10-63cb-42a2-9812-1384c097ae35
# ╠═626c4687-0719-4651-bb3b-1d638d936b7e
# ╠═9ee344ee-e3a0-44c0-9627-6855e942c789
# ╠═34e7c893-902f-4868-8855-ad83b56b4b8c
# ╠═6c7e3124-ea5f-4e58-820a-abaf55fed480
# ╠═009b37eb-f3a0-418b-971c-0bcbe9ef94fb
# ╠═c2db935d-f49c-4538-acbd-de75399ae932
# ╠═2de6853a-9c0b-414f-a3fa-af38bf407a6a
# ╠═e2bf6f84-a9f1-4dc4-be6a-3280451cc1ae
# ╠═c901457f-312b-4dee-98ed-b81493f56030
# ╠═b1a61755-8791-48e6-90dd-cb6023034395
# ╠═4e6fe563-2c1b-42dc-a83e-3c4207e447d2
# ╠═107f0e6d-a9a1-4414-bf45-b0b0b1c57c67
# ╠═ee04f0e0-3a93-4adf-9b90-83987e1f1d1e
# ╠═e6da06de-fc3e-4a89-868f-62dc47490126
# ╠═a2efce21-5f2a-43b9-9e1b-1861220617a7
# ╠═ed5802e5-65a1-4e8c-a633-613a07a3bfec
# ╠═c0634c82-f36c-4bfa-8284-564adc309932
# ╠═3aeeeb61-e004-4317-81c7-aa37d7ade55e
# ╠═ee03f50a-3def-44aa-b14d-c4b5da7a9a63
# ╠═72dfa3c2-ec92-4c97-98a7-525964218356
# ╠═6d699f5b-0ac0-40b9-a601-ec0205131cdd
# ╠═08c1fbea-ad4f-414d-a942-6445a5fc8f62
# ╠═2c1e30ce-f3fa-4a67-b4f3-0587f466ec00
# ╠═12cb9501-d815-45ef-84b2-2886e180a90c
# ╠═ecc4cd83-cc73-4358-8df5-25d566b36185
# ╠═cbb9f819-2645-4f7d-9c61-537041bd5466
# ╠═263b9a78-34bb-44a5-bf76-b5d402a4579e
# ╠═52cf77af-1fee-4b47-8f02-5c94e060a401
# ╠═50f35a40-8fee-4a3f-b3a9-b344a8c4253e
# ╠═6e8eafa8-6854-4b4b-8a02-a82f08314505
# ╠═81ecd06e-8c13-4dc0-81c9-ed575b8303bb
# ╠═95cf6d4e-a89b-40c1-a6b0-2f0692c27651
# ╠═eccb8cec-d709-4682-bc34-2867402a6cfc
# ╠═86bbd468-ecc4-4026-9dd4-5d8f2b9d50dc
# ╠═e69776d2-3640-4c9f-aef2-d30a94dee390
# ╠═8ba893b5-97fc-4a41-9dc5-67f9c11708bc
# ╠═acec4361-d271-41dd-b6cf-4571eae16406
# ╠═38fb2132-8f03-4b5c-aa76-a265bac69497
# ╠═454d0957-0cdc-4490-bbdc-8409b07cddcd
# ╠═ff622ae3-b4ea-4b0c-90cb-a6d1cd7c857e
# ╠═c49773c7-cb73-437c-abb2-3e05e9b3c4f7
# ╠═cd93d1b5-b587-4dc3-ae93-de0489163c3a
# ╠═96202339-68d6-4d8b-af6e-f56e4b6b282d
# ╠═fd9351e2-e0b8-4042-b2d2-0b8cddf76b8a
# ╠═efdf00c9-f0b0-4d9b-b940-e0f4168220ac
# ╠═c1ad8951-554a-4f9c-ac02-2b86c69210e9
# ╠═005f08fc-15b8-4927-bf4f-6f656bd7c509
# ╠═0b81cbeb-e441-4ff7-8586-4aaaa14a5204
# ╠═85c381d1-aa5b-4e36-b764-4f2c08056723
# ╠═bdab1a2a-e3e9-4dd6-ba5a-3f1cbd430e9a
# ╠═d348eb2c-ce88-4813-9fdd-dbb9f6263c79
# ╠═f66dca42-73e6-4ed9-be87-8092f45f75ae
# ╠═87c933d0-d56f-41ec-9740-42da3aea7b02
# ╠═adef617a-8b1f-4198-ba22-95c2fc23e487
# ╠═7d8430ce-3b06-4007-a091-dd00ebe5a4bd
# ╠═46f31f61-afaa-4788-8f44-b83face4b005
# ╠═cb438dec-931a-4856-91ad-809d9d4d9106
# ╠═490769ee-72b2-46cd-aa88-e5b3bfe2ca9e
# ╠═6310d056-f97b-444e-b257-3b22774f7e86
# ╠═e946a789-e9e1-4f46-b7b6-d278c0d6234c
# ╠═bcae0cbd-d30f-458a-bc74-e969dab36ed1
# ╠═783edc23-96fe-4484-bef0-7666668171ac
# ╠═a63091de-654b-43fa-93ab-466fb7ad7f38
# ╠═5e351fca-85ea-4e52-b607-e693deac1719
# ╠═64d4462f-f8fd-4186-9d48-dffd76c12fe6
# ╠═38a542dc-eee3-45b5-a52f-e342af3da728
# ╠═e2518ebc-0bfe-4ce4-9775-cd2c5abaf201
# ╠═49c607c2-c386-4ba9-817b-c80317c0c51f
# ╠═3bf66bee-e84b-4293-83f0-b5af13a3f3eb
# ╠═c2d3f70e-19ef-4e59-9d22-5728a1e0f0e7
# ╠═ff666cf9-42dc-4dfc-88bc-6ccd5f1065d5
# ╠═222b9658-7aba-426a-a5bd-42dee53f4365
# ╠═46253de4-245c-449f-9144-5fbe0fe52af1
# ╠═99a8113d-19c3-484c-a589-d75174b27422
# ╠═adb5bf96-3f83-41ac-bfb0-2e2e1ee2e8b6
# ╠═362bf8c3-e5d4-4631-849e-9f1af5264453
# ╠═79a0555b-3815-4a8a-ad82-297bb0721c34
# ╠═4ac3df0d-cf63-4cab-8c7c-6ce37a3589b2
# ╠═3845701a-4d36-4b40-a5e9-df3b3578c7a5
# ╠═38f77f4d-da45-4ebf-9916-a3ddb03fb39e
# ╠═17536f1d-bbb0-46d9-91a6-e094b749ec9e
# ╠═9eeb9b8a-c943-421c-a414-7bd7069bbcae
# ╠═374a0805-1ed4-4eef-bab7-cc4da4659a72
# ╠═1dd794a3-61c0-4f27-af0d-89bfdc973bdb
# ╠═d9a58858-2bb1-44b3-a4c6-30b5d62936c4
# ╠═fe58c5a4-8193-440d-be36-ac989017dc42
# ╠═4b158c96-0273-46f1-b6fe-c75fb0974dae
# ╠═371e9b4c-1a94-42a9-b4ee-a837bd005a7a
# ╠═fd45ccc8-7d10-4081-b681-ea398248b495
# ╠═05e57f17-784e-49e5-815e-f7d94aea5ab8
# ╠═466b9320-6fe1-41df-9dae-7c90a12fca5d
# ╠═8ae1afae-ea67-49d9-be53-7909885fb083
# ╠═91559ca4-aa63-409c-a9da-c02726121bee
# ╠═27cdd96d-774e-4afb-b680-4f3f52a21e94
# ╠═f23449ba-ad22-4f75-a896-3aa8f94a3b74
# ╠═0d499e42-4467-4384-a5f9-193f259fec60
# ╠═6b3dc5c1-7c61-47fc-ae1b-03f4116de245
# ╠═27d5e59d-e9a0-49b3-805b-1637a5e9d078
# ╠═ca1077c7-6bfe-406f-95d5-1686328022e2
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
