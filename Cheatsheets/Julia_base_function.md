# A collection of Julia base functions
Many are often applicable to several types and data structures. 

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
```
  addr = "julius.caesar@rome"
  uname, domain = split(addr, '@'); 
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

* Rememeber that an array has more information associated with it than simply
it's contents, it also has the index values of the elements within it's
contents, which can be utilized and computed with - but often this index value must be accessed, or even, created, by another function - for example with enumerate.   

##### list out the elements of a tuple with their associated index 
If we have five elements in a tuple, and we want to perform some functions on these elements AND utilize their index values, we can give enumerate a go;  
```
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
```
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

##### construct regex patterns to play with using the **Regex()** and **r** functions: `match(r"[^abn]", banana)`
```
function usesonly(word, available)
    r = Regex("[^$(available)]")
    !occursin(r, word)
end
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
``` 
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
```
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




## File IO, Directories, Navigation 

##### obtain the contents of an IObuffer as an array, afterwhich the IObuffer is reset to its initial state: `take!(io)`   

##### walk through a directory, listing its contents: `walkdir("path/path")`  
Similar to **tree** on unix systems - perhaps more recursive. 

##### print out the contents of a directory as an array: `readdir("path/path")`    
Really handy for iterating through the contents of a directory, of the many many handy uses.    

##### print current working directory: `pwd()` 

##### verify whether something is a file or a directory: `isfile("file"), isdir("/path")`     

##### print the absolute path of a file: `abspath("file")`    

##### execute a shell command within julia: `run`ls`, read(run(`ls`), String)`
The second command will *read* out the output the command as a String   

##### import/use a module-function but under a different alias: `import BenchMarks: read as BMar`     

##### import/use only certain components of a module: `using .BenchMarks: timelag, NP`    


## General   

##### check whether a particular element or entity is of a specific type: `x **isa** Int64`    

##### print the field names of an object/structure: `fieldnames(object)`     
> (:x, :y)       

##### list the methods which a function can operate on, e.g. on custom structures, Int64, Any.: `methods(sum)`    

##### a macro to show which types a function is operating on: `@which sort!(hand)`    
When overflowing/overriding methods and functions, such as extending sort!() to
work on custom structs and types, it can become confusing as to which function
one is working with e.g. the overloaded base one, or an unconfigured default.
Especially helpful when importing external packages.    

##### find the parent type of a subtype - it's 'supertype': `supertype(card)`     

##### keyword arguments are defined in functions when we want to be a bit more explicit in our function calls -- we must remember to use the *;* semicolon after the last ordinary argument:   
```
function plotter(x, y; trend_color="black", intersect_color="red")
    something
end

plotter(1:10, 2:10, trend_color="blue", intersect_color="brown")     
```
##### declare an abstract Type which can have progency types/subtypes: `abstract type Gene end`  
Writing functions and methods for the abstract type should propagate to their subtypes.   

##### the ternary **?** operator is a short hand for an in-else statement: `5 % 2 = 1 ? println("yes") : println("no")`      

##### declare a primitive Type: `primitive type Float64 <: AbstractFloat 64 end`    
The number between the subtype and end indicates how many bits are required.   

##### method definitions can also have type parameters qualifying their signature: `isintpoint(p::Point{T}) where {T} = (T == Int64)`    

##### create a Type which is a union of different subtypes, allowing it to take on different type values: ` IntandString = Union(Int64, String)`     

##### missing values are themselves a specific kind of type - they are not just absent and NA, but do in fact have some sort of contradictory value - the "missing" type: `a = [1, missing]` to create an array which the value 1 and a missing value also. When we want to skip and ignoring these missing values, say, when loading into a DataFrame or performing some function, we can use the **skipmissing()** function: `mean(skipmissing(a))`

##### measure/time the execution of code using the @time macro: `@time function(arg)`
See the package **BenchmarkTools** for additional performance measurement functionality. 
> A function in Julia is compiled the first time it is executed. So to compare two algorithms, they have to be
implemented as functions to get compiled and the first time they are called has to be excluded from the performance measure, otherwise the compilation time is measured as well.
> The package BenchmarkTools (https://github.com/JuliaCI/BenchmarkTools.jl) provides the macro
@btime that does benchmarking the right way. So just use it! 


## Blocks
Blocks allow for the grouping and compartmentalization of sets of statements, there are several kinds of blocks; begin, let, do.

##### begin blocks are a nice grouping bracket 
```
begin
    something
    somethingmore
    more
end 
``` 

##### let blocks allow for new bindings to be created between values and variables, to mediate between global and local variables/scopes
```
z y x = 2 3 1

let x = 5
    @show x y z 
end
```
In the function above, x is redefined locally by **letting** it be a different
value, whilst the remaining variables will be printed as per their global
values     

##### do blocks are often handy when working with IO flow, reading and writing files. One of their main advantages is that they handle the closing of the stream automatically and thus the IO doesn't haven't to be closed explicitly
```
data = "whole lotta red"

open("newfile.txt", "w") do writer
    write(writer, data)
end 
```





























