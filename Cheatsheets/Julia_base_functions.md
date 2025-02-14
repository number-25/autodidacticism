# A collection of features, functions and implementations in Julia
Many are often applicable to several types and data structures. 

[Dictionaries](#Dicts)  
[Tuples](#Tuples)  
[Strings](#Strings)    
[DataFrames](#DataFrames)   
[Arrays](#Arrays)  
[File IO, Directories, Navigation](#File-IO,-Directories,-Navigation)  
[General, Assorted](#General)  
[Loops, Iteration](#Looping-and-iterating)   
[Blocks](#Blocks)  
[Numbers](#Numbers)  
[Control Flow](#Control-Flow)  
[Missing and Nothing values](#Missing-and-Nothing-values)   



## Dicts

##### get a key-value pair: `get(collection, key, default)`   
From a dict, **get** the value associated with a defined key, and if the key is
not present, output another value (default) - this is another way of doing a
conventional index based look up: `dict[key]` 

##### reverse lookup: `findall(isequal(value), dict)`  
Compared to a conventional forward lookup, whereby we search for the value
associated with a specific key, here we search for the presence of values in
the dict irrespective of the key, and often we don't know the key itself. This is a combination of two functions. 

##### sorting the values of a dict: `sort(collect(dict), rev=?, by=x->x[2])` 
Sorting a dict itself is not something undertaken in Julia, my guess is that
the hash based access of a dict prohibits such an operation, or the fact that
the sort function modifies the data structure/type, and Dict by nature are not
orderable (but look into the DataStructures.jl StructuredDict type). Here we
transform the Dict into an array, and sort by x, with x being the contents of
the second column of the array, which are the values of the dict. Toggling the
rev= option will indicate whether we should sort in reverse or not.  

## Tuples 

##### split a tuple based on a character: `split(tuple, 'character')` 
We can split a tuple (or string) and use any character as the splitting delimiter. See for instance;
```julia
  addr = "julius.caesar@rome"
  uname, domain = split(addr, '@'); ␂
```
We can assign the various components of the string/tuple to their own tuples,
and as you expect, we want the number of tuples to correspond to the number of
elements after splitting.    

##### get the product and the remainder of a division: `divrem(a, b)`
This will take two numbers and perform a division operation with them, then
return the product (quotient), and the remainder of the operation as two
tuples, which themselves can be assigned to new variables; `q, r = divrem(90,
23)`.    

##### get the minimum and maximum of a sequence: `minmax('1', '2')` 
Imagine computing `minimum(a)` and `maximum(a)`, a being a tuple, and outputing this in a single line.   

##### extrema() - similar to that above 

##### zipppppppp open two tuples and rezip them together like a hoodie: `zip(a, b)`
If we have two tuples containing an equal number of elements, and we would like
to combine them so that each element at each matching index is now side by
side, we can use the zip() function; `zip((1, 2, 3), (3, 2, 1))` would produce
something like - **3-element Vector{Tuple{Int64, Int64}}:**     
(1, 3)   
(2, 2)   
(3, 1)   

* Remember that an array has more information associated with it than simply
it's contents, it also has the index values of the elements within it's
contents, which can be utilized and computed with - but often this index value must be accessed, or even, created, by another function - for example with enumerate.   

##### list out the elements of a tuple with their associated index 
If we have five elements in a tuple, and we want to perform some functions on these elements AND utilize their index values, we can give enumerate a go;  
```julia
a = ["a", "b", "c"]   
   for (index, value) in enumerate(a)
           println("$index $value")
       end
```
1 a   
2 b   
3 c    

##### named tuples can serve as 'dict' like data structures whereby we define the tuple elements are based x = y mappings which can be accessed using the dot syntax as per indexing:
```julia
named_tuple = (this = 1, that = 2)
named_tuple.this
```


## Strings

##### count the occurrence of a character in a string: `count(i->(i=='f'), "foobar, bar, foo")`
Typically count is used to count integers, but it can be adapted to count characters in a string relatively easily. Here the option tells counts that we should operate on i, and i equals (==) the character 'f'. Here's an example of this function, used to count the letter frequency of a string.  
```julia
   function mostfrequent(string)
    emptydict = Dict()
    for letter in lowercase(str)
        if letter ∉ keys(emptydict)
            q = count(i->(i==letter), lowercase(str))
            emptydict[[letter]] = [q]
        else 
            return 
        end 
    end 
    sort(collect(emptydict), by=x->x[2], rev=true)
end
```

##### return a string representation of an object - take the object and output the way it's formatted: `repr(s), dump(s)`   
When you are reading and writing files, you might run into problems with whitespace. These errors can be hard to debug
because spaces, tabs and newlines are normally invisible.     

##### Avoiding complicated escape combinations in strings. In instances in which we want to print a string which contains multiple special characters, which should not be interpolated and interpreted as newlines, instead of embedding escape characters amongst the string literal, we can simply prefix the entire string with **raw**, turning the string into a raw literal. For example this would help greatly if we want to pring file paths and the like: `raw"C:\my_folder\my_file.txt"` 

##### 'chop' n, m characters from the head and fail of a string: `chop("abcd", 1, 2)` with output 'b' 

##### print the UTF-8 byte encoding of a character: `codeunits()`

##### check to see if the string is ASCII encoded: `isascii()`  

##### convert a String to a suitable fixed-width StringType:
```julia
using InlineStrings
s1 = InlineString("x")
s2 = inlinestrings(["abcs", "aaaaa", "dan"]) 
```

##### observe the memory footprint of a variable: `Base.summarysize(s1)` 

## DataFrames
##### create a simple empty vector from predefined column-names `sample_df = DataFrame([name => [] for name in column_names])`   

##### ask whether certain values are *in* the dataframe rows using the **in** function with broadcasting: `data.newvariable = in.(data.weight, [["120kg", "220kg"]])` 
You must enclose the strings in double square brackets as otherwise the broadcasting will not iterate over both elements and a dimension error will be thrown - this is a super important note. When you enclose the array containing two elements in another array, you effectively create a single element array, which circumvents the dimension error.   

##### simple ifelse function to create binary variables if certain conditions aren't met: 
```julia 
rest_data.wrongZip = ifelse.(rest_data.zipCode .< 0, true, false)
# for multiple conditions - all values that are either missing or not 6 in AGS or 3 in ACR are false 
first_q.largeLand = ifelse.((ismissing.(first_q.AGS)) .| (first_q.AGS .!= 6) .| (first_q.ACR .!= 3), false, true) 
```

##### get the column index of a data frame: `columnindex(data, "columnname")`    

##### check if a column of a specific name is in the data frame: `hasname(data, "columname")`    

##### rename dataframe columns:
```julia
column_names = ["id", "title", "price"]
rename(df, column_names)
```

## Arrays

##### delete elements of an array by their index: `deleteat!(array, [index])`   
This is a really handy base function which can take an array on indexes itself,
meaning we can remove multiple elements from our main array.     

##### remove and output an element at a given index: `splice!(array, index)`


##### combine a collection of arrays (or other iterable objects) of equal size into one larger array, by arranging them along one or more new dimensions: stack(structure; dims) 
I have used this to break and array of arrays down into a matrix which can be
iterated through - for instance I had multiple values inside an array within
each row of a dict, which I was attempting to 'flatten' out into a single
column vector/array to iterate through, and this was one way of achieving
this -- perhaps not the best way to go about it however... it must be noted that this will only work if each subarray is of the same size, in this case = 2
```julia
samp = [["today", "yesterday"], ["tomorrow", "morning"]]

for f in stack(samp) ; println(f); end
```

> today
> yesterday
> tomorrow
> morning    

Another option is to use the vec() function as such: vec(a::AbstractArray) -> AbstractVector

Reshape the array a as a one-dimensional column vector. Return a if it is
already an AbstractVector. The resulting array shares the same underlying data
as a, so it will only be mutable if a is mutable, in which case modifying one
will also modify the other.   
```julia
a = [1 2 3; 4 5 6] 
vec(a)
```

> from [1 2 3, 4 5 6]
> to 
> 1
> 2
> 3
> 4
> 5
> 6    

##### get the value of an array which you are definitely sure contains only a single element - this would avoid indexing
```julia
# From this
json_query.rates[1].mid

# To this
only(json_query.rates).mid
```
This works since the `rates` field only has a single index ([1]) which contains 3 fields, mid being one of them. Errors will be thrown if there is a violation of `0 < x < 2` 

## File IO, Directories, Navigation

##### view the size of the objects-datasets in your environment: `varinfo(, args)`      

##### obtain the contents of an IObuffer as an array, afterwhich the IObuffer is reset to its initial state: `take!(io)`   

##### walk through a directory, listing its contents: `walkdir("path/path")`  
Similar to **tree** on unix systems - perhaps more recursive. 

##### print out the contents of a directory as an array: `readdir("path/path")`    
Really handy for iterating through the contents of a directory, of the many many handy uses.    

##### print current working directory: `pwd()` 

##### verify whether something is a file or a directory: `isfile("file"), isdir("/path")`     

##### print the absolute path of a file: `abspath("file")`    

##### @__FILE__ macro will expand to the absolute file path of the file in question: if the current directory is /my_dir and the file is scan.jl, then `@__FILE__` expand to /my_dir/scan.jl

##### @__DIR__ macro will expand to the absolute directory in question: `@__DIR__` will expand to /my_dir 

"If Julia is running code in a file, @__FILE__ should give you the full path to
that file and @__DIR__ should equal dirname(@__FILE__). If you are running code
directly in the REPL, @__DIR__ should give you the same result as pwd() and
@__FILE__ will (*) give you a string indicating you are running from the REPL.
If you are evaluating code in some IDE you need to consult its documentation to
find out how it does that or at least tell us what environment you are working
in." [From here](https://discourse.julialang.org/t/should-dir-give-a-path-to-the-directory-of-the-current-file/71303)


##### execute a shell command within julia: `run`ls`, read(run(`ls`), String)`
The second command will *read* out the output the command as a String   

##### import/use a module-function but under a different alias: `import BenchMarks: read as BMar`     

##### import/use only certain components of a module: `using .BenchMarks: timelag, NP`    

##### memory mapped IO for loading large datasets not able to be stored in memory: `using Mmap; mmap(s, Matrix{Int}, (m,n))`    
See more details [here](https://docs.julialang.org/en/v1/stdlib/Mmap/#Memory-mapped-I/O)

##### read a csv from a url directly into a DataFrame using CSV and HTTP packages: 
```julia
using CSV, HTTP, DataFrames
csv_import = CSV.read(HTTP.get("url").body, DataFrame)
```

## General   

### Functions

##### define a single line function: `divideten(x::Interger) = x / 10`    
Another simple one. 
```julia
f = <(4)
f(3)
```

##### function composition and piping/chaining. Combine functions by using the unicode circle character: `map(first ∘ reverse ∘ uppercase, split("you can compose functions like this")` 
To use the compose character type `\circ<tab>`. This will apply each function one after the next to our input data. Very cool. 

We can also use the piping operator to do the same thing: `1:10 |> sum |> sqrt`  

The pipe operator can also be used with broadcasting, as .|>, to provide a useful combination of the chaining/piping and dot vectorization syntax
`["a", "list", "of", "strings"] .|> [uppercase, reverse, titlecase, length]`

##### define the return type of a function:
```julia
function divrem(x, y)::Int8
  something
  something
end 
```

##### list the methods which a function can operate on, e.g. on custom structures, Int64, Any.: `methods(sum)`    

##### a macro to show which types a function is operating on: `@which sort!(hand)`    
When overflowing/overriding methods and functions, such as extending sort!() to
work on custom structs and types, it can become confusing as to which function
one is working with e.g. the overloaded base one, or an unconfigured default.
Especially helpful when importing external packages.    


##### tuples of size would need to contain a comma after the first element for otherwise a tuple wont be created and the variable will simply take on the elements Type: `t = (1,)` 

##### use ignored elements in variable names in order to assign a specific value from an iterator - pretty bizarre but it is an option to have in mind:
```julia
_, _, _, d = 1:10
```
d will have the value 4. "If only a subset of the elements of the iterator are required, a common convention is to assign ignored elements to a variable consisting of only underscores _ (which is an otherwise invalid variable name, see Allowed Variable Names)"

##### empty the contents of a collection e.g. dict, array: `empty!(dict)`    

##### check whether a particular element or entity is of a specific type: `x **isa** Int64`    

##### print the field names of an object/structure: `fieldnames(object)`     
> (:x, :y)       
##### show and expand the macro transformed code, revealing what's behind the curtain : `@macroexpand @macro something`    

##### see if a variable is defined using the @isdefined macro: `@isdefine q` and `z = @isdefined q` which will be stored as a boolean     
This is similar to other function **isdefined()** and **isassigned()**.     

##### find the parent type of a subtype - it's 'supertype': `supertype(card)`     

##### find the supertypes of an elements type: `supertypes(typeof(x))`     

##### find the subtypes of a type: `subtypes(type)`     

##### find the common type (if there is one) between two different elements - this is useful when creating function and methods which work on multiple related types, in the case of multiple dispatch. This creates more 'general' and malleable methods: `typejoin(typeof(x), typeof(y))`    

##### promote values of mixed type to a common type - this will only work when the types are interconvertible e.g. Int to a Float64 `promoter(1, 2.5, 3)` 
> (1.0, 2.5, 3.0)

##### convert value from one type to an another (if possible) e.g. if x is a Int64 `convert(UInt8, x)`  

##### check to see if a type is of an abstract or concrete type form: `isabstractype(x)` and `isconcretetype(y)`      

##### assign a collection a to be a UNION of a specific type: `q = AbstractVector{<:Real}`   
This will allow any elements of the type Real to be stored in it, and types such as AbstractType{Int} and AbstractType{Real} will be subtypes of this UNION.        

##### If we have a sample collection of elements which will serve as a reference for our methods/functions, we can determine the Type of the collection by broadcasting the **identity()** function over our collection: `identity.([1.0, 1, 1.5])` and `identity.(Any[1.0, 1, 1.5])`    

##### keyword arguments are defined in functions when we want to be a bit more explicit in our function calls -- we must remember to use the *;* semicolon after the last ordinary argument:   
```julia
function plotter(x, y; trend_color="black", intersect_color="red")
    something
end

plotter(1:10, 2:10, trend_color="blue", intersect_color="brown")     
```
`kawargs...` provided in the varargs … form are stored as key-value pairs, whereby the argument can be provided to the function in the typical `function(x; kawarg1=1)` or using Dict mapping notation `function(x; :kawargs => 1)`, which you may have seen in the `plot()` examples

##### varargs arguments (variable) in function designations allow for the input of additional arguments other than those specifically required for the function: `myfunction(x, y...)` 
Here, the function will be structured in a way that handles additional arguments - variable number arguments
i

##### extra keywords can be collected using … as with varargs: 
```julia
function f(x; y=0, kwargs...)
    ###
end
```

##### optional - default arguments whereby a function has predefined arguments which can be changed on input: `date(y::Int64, m::Int64=1, d::Int64=1` 
If the user doesn't provide m or d variables, the default to 1, but if
they do provide these variables than they are assigned in the expected
way. *"Optional arguments are actually just a convenient syntax for
writing multiple method definitions with different numbers of arguments
(see Note on Optional and keyword Arguments). This can be checked for
our date function example by calling the methods function:"*   


##### Parse a string as a number. If the type is an integer type, then a base
can be specified (the default is 10). If the type is a floating point type, the
string is parsed as a decimal floating point number. If the string does not
contain a valid number, an error is raised. `parse(Int64, "1234")` and
`parse(T::Type, string, base=Int)`  

##### declare an abstract Type which can have progeny types/subtypes: `abstract type Gene end`  
Writing functions and methods for the abstract type should propagate to their subtypes.   

##### the ternary **?** operator is a short hand for an in-else statement: `5 % 2 = 1 ? println("yes") : println("no")` and another example:
```julia
# Instead of writing 
x = 5
if x < 5
  println("x is less than 5")
else
  println("x is equal to or greater than 5")
end 
# We can one liner is 
x < 5 ? println("x is less than 5") : println("x is equal to or greater than 5") 
```

##### declare a primitive Type: `primitive type Float64 <: AbstractFloat 64 end`    
The number between the subtype and end indicates how many bits are required.   

##### method definitions can also have type parameters qualifying their signature: `isintpoint(p::Point{T}) where {T} = (T == Int64)`    

##### determine which *types* of elements/values a *collection* can hold: `eltype()`  


##### filter datasets based upon specific conditions - get values that equal z from data y: `filter(x -> x == z, y)` or `filter(x => equals(x), y)`     

We can do a lot more elegant multi-line filtration for multiple conditions using the do blocks
```julia
dr = Dates.Date(2015):Dates.Day(1):Dates.Date(2016);
filter(dr) do x
    Dates.dayofweek(x) == Dates.Tue &&
    Dates.April <= Dates.month(x) <= Dates.Nov &&
    Dates.dayofweekofmonth(x) == 2
end
```

##### invert the function to also take advantage of filter(): `filter(line -> !isempty(line), readlines(filename))` 


##### It can even be extended to strings using `endswith("somefile.png", ".png")`

## Looping and iterating

##### allow element-wise broadcasting over arrays, instead of treating the array as a single element, using **Ref** function: `in.([1, 3, 5, 7, 9], Ref([1, 2, 3, 4]))`   

Ref can be seen as shorthand for "Reference" - it takes the values of a collection, and creates a single value reference of the value, which it stores in an array, almost like a little iterator of it's own. So when we run broadcasting in combination with **Ref()**, Ref will operator on each element of the array, and thus the size of the first and second arrays will be equal (1 each), allowing for the broadcasting to work as intended.... a bit random but hey this is effective.

### Continue and Break 
##### using continue and break in our loops allows for additional control of the flow of execution - we can embed continue so that a particular iteration is skipped and the next item is evaluated, and we can use break to literally break! the loop where it is and end it: 
```julia
x = 0 
while true 
    global x += 1 
    x > 6 && break 
    isodd(x) && continue 
    println("x is even")``
end 
```

### map 
##### "map" a function, such as mean(), to all the columns of a matrix or ?dataframe? **using eachcol()**: `map(mean, eachcol(matrix))` 

##### execute a function along with **eachcol** in a way similar to natural language - 'do this, for column in eachcol(x)': `[mean(col) for col in eachcol(x)]`      
We enclose it in square brackets because we're actually storing the output sequentially in an array!


## Blocks
Blocks allow for the grouping and compartmentalization of sets of statements, there are several kinds of blocks; begin, let, do.

##### begin blocks are a nice grouping bracket 
```julia
begin
    something
    somethingmore
    more
end 
```

##### let blocks allow for new bindings to be created between values and variables, to mediate between global and local variables/scopes
```julia
z y x = 2 3 1

let x = 5
    @show x y z 
end
```
In the function above, x is redefined locally by **letting** it be a different
value, whilst the remaining variables will be printed as per their global
values     

##### do blocks are often handy when working with IO flow, reading and writing files. One of their main advantages is that they handle the closing of the stream automatically and thus the IO doesn't haven't to be closed explicitly
```julia
data = "whole lotta red"

open("newfile.txt", "w") do writer
    write(writer, data)
end 
```

## Numbers
### Floating Point 
##### adding two floating point numbers together and asking if they equal said combinant will not work `3.0 + 2.0 == 5.0` due to the way that floating point numbers are handled in computing. Since floats are always approximations of intergers, there is precision error involved and thus logically the computer cannot say that it's estimate of precision is true - for it isn't. So instead, for pragmattic purposes we can use the **isapprox(x + y, z)** function to evaluate a conditional `isapprox(3.0 + 2.0, 5.0)` will return true    

## Control Flow
### Error Handling
##### try-catch-end block for dealing with specific errors and determining the course of action. **retry** with throw an actual error exception if we encounter something other than our StatusError:
```julia
try
    response = HTTP.get(query)
    json = JSON3.read(response.body)
    only(json.rates).mid
catch e
    if e isa HTTP.ExceptionRequest.StatusError
        missing
    else
        rethrow(e)
    end
end
```

## Missing and Nothing values
##### missing will propagate when used in operations:
```julia
1 + missing 
> missing

1 * missing 
> missing

missing > 4 
> missing
```
The only thing which will not propagate a missing is a boolean comparison to `true`: `true | missing` will evaluate to `true`

##### use the coalesce(values, true/false) to specify how missing is to be treated in the particular execution and if it will evaluate to true or to false: `coalesce([1, true, missing, 10], true` will evaluate to
> 1, true, true, 10

We can also convert missing values to other values using coalesce: `coalesce.([1, missing, 20], 0)`     
This will replace all missing values with a 0. 

##### create a new method for a pre-existing function whereby missing values are propagated, whereby they ordinarily wouldn't be:
```julia
using Missings
add(x::Int64, y::Int64) = x + y # will outpout MethodError for missing 
propagating_add = passmissing(add) # will not propagate missing value
```








