---
layout: post
title:  "Object Environment"
tags:
    - programming
    - object oriented
    - education
    - python
    - lecture notes
---

Students often have trouble grasping the difference between objects,
classes, and the variables which hold them. This article aims to explain
object oriented programming by example in Python.

Review
------

First, let us review a few things.

### Variables

To create a variable in Python, we simply need to assign it a value:

{% highlight python %}

a = 10
b = "Tacos"

{% endhighlight %}

Let's consider mapping these variables out as we go into something I'm
going to call an *environment*. Environments are simply tables that map
the known variables to their values. For example, the code above would
have the following environment:

            Variable    | Type     | Value
            ------------------------------
            a           | int      | 10
            b           | str      | "Tacos"

That is, a is a variable that holds the integer 10. We can add new
variables to the environment at will.

{% highlight python %}

not_my_gpa = 4.0

{% endhighlight %}



            Variable    | Type     | Value
            ------------------------------
            a           | int      | 10
            b           | str      | "Tacos"
            not_my_gpa  | float    | 4.0

That isn't very interesting. Neither would be changing a variable.

{% highlight python %}

a = [1, 2, 3]

{% endhighlight %}


            Variable    | Type     | Value
            ------------------------------
            a           | list     | [1, 2, 3]
            b           | str      | "Tacos"
            not_my_gpa  | float    | 4.0

If we wanted to use a variable, then Python would have to look up its
value in the environment table.

{% highlight python %}

print(b) # finds variable b and gives it to the 'print' function

{% endhighlight %}

Sometimes while debugging through a program, it is handy to keep an
environment table updated for each step of execution in the program.
This is known as *tracing a program*.

### Functions

Functions are little snippets of code that complete tasks for us. Say we
wanted to write a function that calculates the square of a number. It
might look like this:

{% highlight python %}

def square(val):
    return val * val

{% endhighlight %}

Now, some cool cool stuff happens here when we create `square`. First,
it is added to the environment table. Yep, `square` is pretty much just
a variable name.

            Variable    | Type     | Value
            ------------------------------
            a           | list     | [1, 2, 3]
            b           | str      | "Tacos"
            not_my_gpa  | float    | 4.0
            square      | function |

I've left the value empty because functions are special. Something *is*
there and it's the body of the function.

Let's call square and see what happens to our environment table.

{% highlight python %}

c = square(10)

{% endhighlight %}

There are several steps that happen here. First, we can see that the
value is going to be stored in to a variable c, but we don't actually
know *what* value yet. So, Python will evaluate the function call for
us. Whenever Python sees a variable name followed by some parentheses,
possibly with arguments such as `10`, it knows it's got to do some stuff
for us.

Python will first retrieve the value at the variable `square` in our
environment. Then, it will execute the code associated it (the value)
given the arguments. Something special happens then with those
arguments. When the function is evaluated, the arguments are set up in
*yet another environment table*, specifically for this *single* call to
`square`.


            Variable    | Type     | Value
            ------------------------------
            a           | list     | [1, 2, 3]
            b           | str      | "Tacos"
            not_my_gpa  | float    | 4.0
            square      | function |

    Function call-> square(10):
                    Variable    | Type     | Value
                    ------------------------------
                    val         | int      | 10

When `square`
finishes up, it will return the value `100`, which we can then assign to
a new variable `c`.

            Variable    | Type     | Value
            ------------------------------
            a           | list     | [1, 2, 3]
            b           | str      | "Tacos"
            not_my_gpa  | float    | 4.0
            square      | function |
            c           | int      | 100

Note that the `square(10)` environment is destroyed because it is no longer
needed! If we called `square` again, a new environment will be created
specifically for it and whatever argument we give it.

Let's look at another example:

{% highlight python %}

def power_of_c(val):
    z = 1
    for i in range(val):
        z = z * c
    return z

{% endhighlight %}

Oh geez, this function is *drunk*. It uses something that is given as an
argument, creates its own variables, and even uses some outside of it.
How is that possible? It is possible through something known as
*scoping*. If we call `power_of_c`, an environment is created
specifically for it, just like when `square` was called.


{% highlight python %}

d = power_of_c(3)

{% endhighlight %}

            Variable    | Type     | Value
            ------------------------------
            a           | list     | [1, 2, 3]
            b           | str      | "Tacos"
            not_my_gpa  | float    | 4.0
            square      | function |
            power_of_c  | function |
            c           | int      | 100

    Function call-> power_of_c(3):
                    Variable    | Type     | Value
                    ------------------------------
                    val         | int      | 3

Now the function begins to execute. The first thing that happens is that
it creates a new variable, `z`, and gives it the value 1.

            Variable    | Type     | Value
            ------------------------------
            a           | list     | [1, 2, 3]
            b           | str      | "Tacos"
            not_my_gpa  | float    | 4.0
            square      | function |
            power_of_c  | function |
            c           | int      | 100

    Function call-> power_of_c(3):
                    Variable    | Type     | Value
                    ------------------------------
                    val         | int      | 3
                    z           | int      | 1

Note that `z` is created *within* the `power_of_c(3)` environment. Next,
we begin our loop and start updating `z` with `z * c`. First loop
through `z` will become 100, since `c` is 100 and `1 * 100 == 100`.

    Function call-> power_of_c(3):
                    Variable    | Type     | Value
                    ------------------------------
                    val         | int      | 3
                    z           | int      | 100

A second time,


    Function call-> power_of_c(3):
                    Variable    | Type     | Value
                    ------------------------------
                    val         | int      | 3
                    z           | int      | 10000

And I think we can see how this ends: with `z` holding integer 1000000.
Finally, `power_of_c(3)` returns the value held within `z`, the
environment is destroyed, and our new variable is created.

            Variable    | Type     | Value
            ------------------------------
            a           | list     | [1, 2, 3]
            b           | str      | "Tacos"
            not_my_gpa  | float    | 4.0
            square      | function |
            power_of_c  | function |
            c           | int      | 100
            d           | int      | 1000000

But how did `power_of_c` know where to find `c` if it wasn't in its
environment? It knows because the environments are *nested* in a sense.
That is, if a variable does not exist within the inner most environment,
Python will try to look it up in the next environment up, or the
environment that was in *scope* when our new environment was created,
which in our case, is our main environment we started with. Let's go
ahead and give that environment a name, how about `global`? Sounds good
to me.

    global:
            Variable    | Type     | Value
            ------------------------------
            a           | list     | [1, 2, 3]
            b           | str      | "Tacos"
            not_my_gpa  | float    | 4.0
            square      | function |
            power_of_c  | function |
            c           | int      | 100
            d           | int      | 1000000

This environment table is special to our program, it's basically where
everything is going to be defined.

Classes and Objects
-------------------

Alright, now that we're good with how environments work, let's finally
create some classes. Let's start with a fresh, empty environment.


{% highlight python %}

a = 1
b = "Tacos"

class Fraction:
    def __init__(self, n, d):
        self.numerator = n
        self.denominator = d

{% endhighlight %}

This class will represent a fraction. A fraction has two parts:
a numerator and a denominator. Now our global environment looks
something like this:

    global:
            Variable    | Type     | Value
            ------------------------------
            a           | int      | 1
            b           | str      | "Tacos"
            Fraction    | class    |


Again, I've left the value of the `Fraction` variable empty. Why?
Because it's going to operate just like a function did in a sense. Let's
make some stuff and see what happens!

To use a class, we call it just like we would a function:

{% highlight python %}

half = Fraction(1, 2)

{% endhighlight %}

Python knows what's up when we do this, and handles "calling" the class
specially. First, we create a new `Fraction` with values 1 and 2. What
happens is that Python realizes we are trying to do a call on a class,
hands off everything to the constructor, known in Python as  `__init__`,
and calls it instead.


    global:
            Variable    | Type     | Value
            ------------------------------
            a           | int      | 1
            b           | str      | "Tacos"
            Fraction    | class    |

    Create object--> Fraction(1,2):
                    Variable    | Type     | Value
                    ------------------------------
                    self        | object   | *
                    n           | int      | 1
                    d           | int      | 2

Or, more specifically:

    global:
            Variable    | Type     | Value
            ------------------------------
            a           | int      | 1
            b           | str      | "Tacos"
            Fraction    | class    |

    Method call---> Fraction.__init__(*, 1,2):
                    Variable    | Type     | Value
                    ------------------------------
                    self        | object   | *
                    n           | int      | 1
                    d           | int      | 2

So, if you were like me back when I was first learning this stuff, you
are asking yourself, *"what the hell is `self` and why does `__init__`
get called with three parameters when I only gave Fraction two
arguments?*" It's because the `self` parameter is going to be the object
we just created. Python is giving us a chance to *init*ialize some
values for this new object before it returns it and assigns it to the
variable `half`. (Real answer: mostly because Python is stupid.)

### What the hell is an object?!

Aye. Now we're at the meat of the subject. An object is simply a thing.
Alright, cya next time!

<br \><br \><br \><br \><br \><br \><br \><br \><br \><br \><br \><br \>

Just kidding.

A handy thing to do is to think of objects as their own *environments*.
So, when `__init__` is called, it is given 1 and 2, and some object
we've named `self`. This `self` variable is just a reference to a new
environment table!

    global:
            Variable    | Type     | Value
            ------------------------------
            a           | int      | 1
            b           | str      | "Tacos"
            Fraction    | class    |

    Method call---> Fraction.__init__(*, 1,2):
                Variable    | Type     | Value
                ------------------------------
                self        | object   | *------\
                n           | int      | 1      |
                d           | int      | 2      |
                                                |
                                                |
        /---------------------------------------/
        |
        V
    <Fraction> object #1:
            Variable    | Type     | Value
            ------------------------------

Right now it's empty, but that's because `__init__` has just started to
execute. What does it do?

{% highlight python  %}

class Fraction:
    def __init__(self, n, d):
        self.numerator = n
        self.denominator = d

{% endhighlight %}

Hm. It uses some sort of dot notation to assign the arguments to
variables. Where are these variables created? Within `self`! Think of
that dot as "we must go deeper in the environments."

<!---- office space gif, way way down ----->

First it creates a new variable *within* `self` named `numerator`, and
assigns it the value of `n`. Then the same for the `denominator` and
`d`.

    global:
            Variable    | Type     | Value
            ------------------------------
            a           | int      | 1
            b           | str      | "Tacos"
            Fraction    | class    |

    Method call---> Fraction.__init__(*, 1,2):
                Variable    | Type     | Value
                ------------------------------
                self        | object   | *------\
                n           | int      | 1      |
                d           | int      | 2      |
                                                |
                                                |
        /---------------------------------------/
        |
        V
    <Fraction> object #1:
            Variable    | Type     | Value
            ------------------------------
            numerator   | int      | 1
            denominator | int      | 2

Welp, that about wraps that up. `__init__` finishes, *implicitly*
returns `self`, and destroys its environment. We are now left with
something that looks like this:

    global:
            Variable    | Type     | Value
            ------------------------------
            a           | int      | 1
            b           | str      | "Tacos"
            Fraction    | class    |
            half        | Fraction | *----------\
                                                |
                                                |
        /---------------------------------------/
        |
        V
    <Fraction> object #1:
            Variable    | Type     | Value
            ------------------------------
            numerator   | int      | 1
            denominator | int      | 2

Note how the value of `half` points to that environment representing the
new object. These are known as *pointers* in other languages, such as C.
(Yep, we're real creative with names in computer science.) Also, its
*type* is a `Fraction`.

So, let's do something with our new fraction. What is its value
represented as a float (decimal)?


{% highlight python %}

d = half.numerator / half.denominator

{% endhighlight %}

Again, notice the dot notation and how it allows us to access the
environment within `half`.

    global:
            Variable    | Type     | Value
            ------------------------------
            a           | int      | 1
            b           | str      | "Tacos"
            Fraction    | class    |
            half        | Fraction | *----------\
            d           | float    | 0.5        |
                                                |
                                                |
        /---------------------------------------/
        |
        V
    <Fraction> object #1:
            Variable    | Type     | Value
            ------------------------------
            numerator   | int      | 1
            denominator | int      | 2

Let's create a few more fractions and have some fun.

{% highlight python %}

third = Fraction(1, 3)
almost_pi = Fraction(22, 7)

{% endhighlight %}

Now our set of environments looks like this (I've left out the calls to
`__init__`):

    global:
            Variable    | Type     | Value
            ------------------------------
            a           | int      | 1
            b           | str      | "Tacos"
            Fraction    | class    |
            half        | Fraction | *----------\
            d           | float    | 0.5        |
            third       | Fraction | *----------)---\
            almost_pi   | Fraction | *----------)---)---\
                                                |   |   |
                                                |   |   |
        /---------------------------------------/   |   |
        |                                           |   |
        V                                           |   |
    <Fraction> object #1:                           |   |
            Variable    | Type     | Value          |   |
            ------------------------------          |   |
            numerator   | int      | 1              |   |
            denominator | int      | 2              |   |
                                                    |   |
        /-------------------------------------------/   |
        |                                               |
        V                                               |
    <Fraction> object #2:                               |
            Variable    | Type     | Value              |
            ------------------------------              |
            numerator   | int      | 1                  |
            denominator | int      | 3                  |
                                                        |
        /-----------------------------------------------/
        |
        V
    <Fraction> object #3:
            Variable    | Type     | Value
            ------------------------------
            numerator   | int      | 22
            denominator | int      | 7


Converting our fraction to a float might be useful enough to put in its
own fuction.

{% highlight python %}

def to_float(f):
    return f.numerator / f.denominator

{% endhighlight %}

    global:
            Variable    | Type     | Value
            ------------------------------
            a           | int      | 1
            b           | str      | "Tacos"
            Fraction    | class    |
            half        | Fraction | *----------\
            d           | float    | 0.5        |
            third       | Fraction | *----------)---\
            almost_pi   | Fraction | *----------)---)---\
            to_float    | function |            |   |   |
                                                |   |   |
                                               ... ... ...

To use `to_float`, we give it an entire Fraction object. Yup. The whole
thing.

{% highlight python %}

many_three = to_float(third)

{% endhighlight %}

    global:
            Variable    | Type     | Value
            ------------------------------
            a           | int      | 1
            b           | str      | "Tacos"
            Fraction    | class    |
            half        | Fraction | *----------\
            d           | float    | 0.5        |
            third       | Fraction | *----------)---\
            almost_pi   | Fraction | *----------)---)---\
            to_float    | function |            |   |   |
                                                |   |   |
                                               ...  |  ...
                                                    |
                                                    |
        /-------------------------------------------+---\
        |                                               |
        V                                               |
    <Fraction> object #2:                               |
            Variable    | Type     | Value              |
            ------------------------------              |
            numerator   | int      | 1                  |
            denominator | int      | 3                  |
                                                        |
    Function call-> to_float(third):                    |
                    Variable    | Type     | Value      |
                    ------------------------------      |
                    f           | Fraction | *----------/

Notice when `to_float(third)`'s environment is created, its parameter
`f` points to the same fraction as the argument `third`. When
`to_float` begins execution, it will use the dot notation to access
values *within* `f`, or as it is here, `third`.

We can apply `to_float` a few times to different `Fraction`s and the
same thing will happen every time.


{% highlight python %}

zero_five = to_float(half)
pi_ish    = to_float(almost_pi)


{% endhighlight %}


    global:
            Variable    | Type     | Value
            ------------------------------
            a           | int      | 1
            b           | str      | "Tacos"
            Fraction    | class    |
            half        | Fraction | *----------\
            d           | float    | 0.5        |
            third       | Fraction | *----------)---\
            almost_pi   | Fraction | *----------)---)---\
            to_float    | function |            |   |   |
            many_three  | float    | 0.333...   |   |   |
            zero_five   | float    | 0.5        |   |   |
            pi_ish      | float    | 3.14...   |   |   |
                                                |   |   |
                                               ... ... ...

Neat-o.

### Methods

Alright. Time to introduce something new. Method, as defined in the
Oxford English Dictionary is:

method, *n.*

A procedure for attaining an object.

1. A recommended or prescribed medical treatment for a specific disease.
2. More generally: a way of doing anything, esp. according to
    a defined and regular plan; a mode of procedure in any activity,
    business, etc.

Actually, this is close enough I can stop here, because if you have
learned anything in computer science yet, you know that we name things
in a *sort-of-but-not-really* fashion. Here's our definition of method:

method, *n.*

A procedure related to an object.

1. See definition for *function*.

What I'm trying to get at is that there is no practical difference
between functions and methods other than *methods are defined within
a class and become part of the environment for objects created from that
class*.

Let's suppose our Fraction class had the `to_float` function built right
in. Starting with a fresh global environment:

{% highlight python %}

a = 1
b = "Tacos"

class Fraction:
    def __init__(self, n, d):
        self.numerator = n
        self.denominator = d

    def to_float(self):
        return self.numerator / self.denominator

half = Fraction(1, 2)
third = Fraction(1, 3)
almost_pi = Fraction(22, 7)

{% endhighlight %}

Now our all our environments are structured like *this*:

    global:
            Variable    | Type     | Value
            ------------------------------
            a           | int      | 1
            b           | str      | "Tacos"
            Fraction    | class    |
            half        | Fraction | *----------\
            third       | Fraction | *----------)---\
            almost_pi   | Fraction | *----------)---)---\
                                                |   |   |
                                                |   |   |
        /---------------------------------------/   |   |
        |                                           |   |
        V                                           |   |
    <Fraction> object #1:                           |   |
            Variable    | Type     | Value          |   |
            ------------------------------          |   |
            numerator   | int      | 1              |   |
            denominator | int      | 2              |   |
            to_float    | function |                |   |
                                                    |   |
        /-------------------------------------------/   |
        |                                               |
        V                                               |
    <Fraction> object #2:                               |
            Variable    | Type     | Value              |
            ------------------------------              |
            numerator   | int      | 1                  |
            denominator | int      | 3                  |
            to_float    | function |                    |
                                                        |
        /-----------------------------------------------/
        |
        V
    <Fraction> object #3:
            Variable    | Type     | Value
            ------------------------------
            numerator   | int      | 22
            denominator | int      | 7
            to_float    | function |

P rad, yeah? Now each `Fraction` object has its *own* `to_float`, much
like how it has its own numerator and denominator. So, how can we use
it?


{% highlight python %}

zero_five = half.to_float()
many_three = third.to_float()
pi_ish = almost_pi.to_float()

{% endhighlight %}


<!-- mind blown gif  -->

Yep, we use the *same* dot notation as before, only this time we attach
a `()` to the end so Python knows we're calling a <s>function</s>
method.

A call to third.to_float() creates environments just like before, only
now `self` is the pointer to `third`:


    global:
            Variable    | Type     | Value
            ------------------------------
            a           | int      | 1
            b           | str      | "Tacos"
            Fraction    | class    |
            half        | Fraction | *----------\
            third       | Fraction | *----------)---\
            almost_pi   | Fraction | *----------)---)---\
                                                |   |   |
                                               ...  |  ...
                                                    |
        /---------------------------------------+---/
        |                                       |
        V                                       |
    <Fraction> object #2:                       |
            Variable    | Type     | Value      |
            ------------------------------      |
            numerator   | int      | 1          |
            denominator | int      | 3          |
            to_float    | function |            |
                                                |
    Method call-> third.to_float():             |
                Variable    | Type     | Value  |
                ------------------------------  |
                self        | Fraction | *------/

**\*busts an air guitar solo\***


### Most things are object-like

In Python, you can treat just about everything like an object, even
strings.


{% highlight python %}

b = "Tacos"
print(b)       # prints "Tacos" to screen
c = b.upper()
d = b.swapcase()
print(c)       # prints "TACOS" to screen
print(d)       # prints "tACOS" to screen

{% endhighlight %}

Neat, yeah? So that means... *dun dun dunnnnnnnnnnnnnn*:

    global:
            Variable    | Type     | Value
            ------------------------------
            a           | int      | *------------------------------\
            b           | str      | *------------------------------)---\
            Fraction    | class    |                                |   |
            half        | Fraction | *----------\                   |   |
            third       | Fraction | *----------)---\               |   |
            almost_pi   | Fraction | *----------)---)---\           |   |
            c           | str      | *----------)---)---)---\       |   |
            d           | str      | *----------)---)---)---)---\   |   |
                                                |   |   |   |   |   |   |
                                               ... ... ... ... ... ...  |
                                                                        |
        /---------------------------------------------------------------/
        |
        V
    <str> object #1: "Tacos"
            Variable    | Type     | Value
            ------------------------------
            upper       | function |
            swapcase    | function |
            ...         | ...      |

<!-- mother of god -->

Yeah, I left a lot out. I am getting lazy and all this taco-talk is
making me hungry, but I think you get the idea: the environment actually
just holds *pointers* to all the objects for variables.

### Classes holding objects that are classes holding objects that are...

Alright, let's get real crazy here before I go eat. In addition to our
Fraction class, we'll add ourselves a MixedFraction. MixedFractions are
whole numbers (ints) and Fraction objects combined together like peanut
butter and jelly. It's beautiful.

And while we're at it, let's go on and create a `to_float` method that
will convert the mixed fraction into a floating point number.

Here goes:

{% highlight python %}

class MixedFraction:
    def __init__(self, whole_num, fraction_obj):
        self.whole_num = whole_num
        self.fraction_obj = fraction_obj

    def to_float(self):
        val = float(self.whole_num)
                # float() is a built-in function that
                # can convert integers to floats.

        val += self.fraction_obj.to_float()
                # ask the fraction for its floating point value!

        return ret

{% endhighlight %}

That's pretty straight forward, yeah? This is known as an *aggregation*
relationship, as MixedFraction is composed of a Fraction, but isn't
responsible for it (i.e., it was created outside of the class.)

Let's make some MixedFractions and look at the environment.

{% highlight python %}

half = Fraction(1, 2)
one_and_a_half = MixedFraction(1, half)

{% endhighlight %}


Now, our environment holds this:

    global:
            Variable        | Type     | Value
            ----------------------------------
            Fraction        | class    |
            MixedFraction   | class    |
            half            | Fraction | *----------\
            one_and_a_half  | MixedF...| *----------)---\
                                                    |   |
                                                    |   |
        /---------------------------------------+---/   |
        |                                       |       |
        V                                       |       |
    <Fraction> object #1:                       |       |
            Variable    | Type     | Value      |       |
            ------------------------------      |       |
            numerator   | int      | 1          |       |
            denominator | int      | 2          |       |
            to_float    | function |            |       |
                                                |       |
        /---------------------------------------)-------/
        |                                       |
        V                                       |
    <MixedFraction> object #1:                  |
            Variable    | Type     | Value      |
            ------------------------------      |
            whole_num   | int      | 1          |
            fraction_obj| Fraction | *----------/
            to_float    | function |

If we were to, for example, call `to_float` on `one_and_a_half`, what would
happen?

{% highlight python %}

z = one_and_a_half.to_float()

{% endhighlight %}

I'll work this one step by step. I just ordered Jimmy John's for
delivery so we got time.

First, we *ask* `one_and_a_half` to execute the `to_float` method. A new
temporary environment is created for it to work in, but isn't very
interesting since `MixedFractions.to_float` needs no parameters:


    global:
            Variable        | Type     | Value
            ----------------------------------
            Fraction        | class    |
            MixedFraction   | class    |
            half            | Fraction | *----------\
            one_and_a_half  | MixedF...| *----------)---\
                                                    |   |
                                                    |   |
        /---------------------------------------+---/   |
        |                                       |       |
        V                                       |       |
    <Fraction> object #1:                       |       |
            Variable    | Type     | Value      |       |
            ------------------------------      |       |
            numerator   | int      | 1          |       |
            denominator | int      | 2          |       |
            to_float    | function |            |       |
                                                |       |
        /---------------------------------------)---+---/
        |                                       |   |
        V                                       |   |
    <MixedFraction> object #1:                  |   |
            Variable    | Type     | Value      |   |
            ------------------------------      |   |
            whole_num   | int      | 1          |   |
            fraction_obj| Fraction | *----------/   |
            to_float    | function |                |
                                                    |
                                                    |
    Method call-> one_and_a_half.to_float():        |
                Variable    | Type     | Value      |
                ------------------------------      |
                self        | MixedF...| *----------/


This should look familiar, because it is the same thing as when we did
`third.to_float()` before. However, the `MixedFractions` version of
`to_float` is a whole lot different when it executes.

Here's `MixedFraction`'s `to_float` for reference:

{% highlight python %}

def to_float(self):
    val = float(self.whole_num)
            # float() is a built-in function that
            # can convert integers to floats.

    val += self.fraction_obj.to_float()
            # ask the fraction for its floating point value!

    return ret

{% endhighlight %}

First, on line 2, it gets the floating point of the whole number part
and stores it to a variable cleverly named `val`.

                                               ...     ...
                                                |       |
        /---------------------------------------)---+---/
        |                                       |   |
        V                                       |   |
    <MixedFraction> object #1:                  |   |
            Variable    | Type     | Value      |   |
            ------------------------------      |   |
            whole_num   | int      | 1          |   |
            fraction_obj| Fraction | *----------/   |
            to_float    | function |                |
                                                    |
                                                    |
    Method call-> one_and_a_half.to_float():        |
                Variable    | Type     | Value      |
                ------------------------------      |
                self        | MixedF...| *----------/
                val         | float    | 1.0

Then, on line 6, it does something we haven't seen before: double dots!
But by now, you should be able to smell what The Rock cookin'.

1. The first dot resolves `self` to the `MixedFraction` object.
2. The second dot resolves `fraction_obj` to the `Fraction` object.
3. Then, we ask *that* `Fraction` to execute *its* `to_float` method.

By the time we've done all of that, we've got this mess:


                                                   ... ...
                                                    |   |
        /---------------------------------------+---/   |
        |                                       |       |
        V                                       |       |
    <Fraction> object #1:                       |       |
            Variable    | Type     | Value      |       |
            ------------------------------      +-------)---\
            numerator   | int      | 1          |       |   |
            denominator | int      | 2          |       |   |
            to_float    | function |            |       |   |
                                                |       |   |
                                                |       |   |
        /---------------------------------------)---+---/   |
        |                                       |   |       |
        V                                       |   |       |
    <MixedFraction> object #1:                  |   |       |
            Variable    | Type     | Value      |   |       |
            ------------------------------      |   |       |
            whole_num   | int      | 1          |   |       |
            fraction_obj| Fraction | *----------/   |       |
            to_float    | function |                |       |
                                                    |       |
                                                    |       |
                                                    |       |
    Method call-> one_and_a_half.to_float():        |       |
                Variable    | Type     | Value      |       |
                ------------------------------      |       |
                self        | MixedF...| *----------/       |
                val         | float    | 1.0                |
                                                            |
    Method call-------> self.fraction_obj.to_float()        |
                        Variable    | Type     | Value      |
                        ------------------------------      |
                        self        | Fraction | *----------/

UGH.

We are talking about line 6 still. Note that the environment for this
call has its *own* `self` within. That `self` is the `Fraction`.
Thankfully this method doesn't do a whole whole lot and returns the
`Fraction` represented as a floating point value pretty much
immediately. So, that temporary environment is destroyed and we are left
with this:

                                               ...     ...
                                                |       |
        /---------------------------------------)---+---/
        |                                       |   |
        V                                       |   |
    <MixedFraction> object #1:                  |   |
            Variable    | Type     | Value      |   |
            ------------------------------      |   |
            whole_num   | int      | 1          |   |
            fraction_obj| Fraction | *----------/   |
            to_float    | function |                |
                                                    |
                                                    |
    Method call-> one_and_a_half.to_float():        |
                Variable    | Type     | Value      |
                ------------------------------      |
                self        | MixedF...| *----------/
                val         | float    | 1.5

Finally, we have our `MixedFraction` as a float, and this method call
environment returns `val` and is destroyed. Now we can update our global
environment with `z`:


    global:
            Variable        | Type     | Value
            ----------------------------------
            Fraction        | class    |
            MixedFraction   | class    |
            half            | Fraction | *----------\
            one_and_a_half  | MixedF...| *----------)---\
            z               | float    | 1.5        |   |
                                                    |   |
        /---------------------------------------+---/   |
        |                                       |       |
        V                                       |       |
    <Fraction> object #1:                       |       |
            Variable    | Type     | Value      |       |
            ------------------------------      |       |
            numerator   | int      | 1          |       |
            denominator | int      | 2          |       |
            to_float    | function |            |       |
                                                |       |
        /---------------------------------------)-------/
        |                                       |
        V                                       |
    <MixedFraction> object #1:                  |
            Variable    | Type     | Value      |
            ------------------------------      |
            whole_num   | int      | 1          |
            fraction_obj| Fraction | *----------/
            to_float    | function |

Awesome.

Inheritance
===========

What if we were drunk and decided to make `MixedFraction` inherit from
`Fraction`? That seems like a totally reasonable thing to do, right?
After all, isn't a mixed fraction just a special representation of
a fraction?

{% highlight python %}

class MixedFraction(Fraction):
    def __init__(self, whole_num, numerator, denominator):
        new_num = numerator + (whole_num * denominator)
        super().__init__(new_num, denominator)

{% endhighlight %}

And look at that, we are pretty much done! MixedFraction will inherit
the Fraction version of to_float, and because of how we wrote our
constructors everything will just *work*. So what about this `super()`
business?

Let's start with a clean environment and make ourselves a `MixedFraction`.

{% highlight python %}

one_and_a_half = MixedFraction(1, 1, 2)
taco = one_and_a_half.to_float()

{% endhighlight %}

    global:
            Variable        | Type     | Value
            ----------------------------------
            Fraction        | class    |
            MixedFraction   | class    |

    Method call-> MixedFraction.__init__(*, 1, 1, 2):
                Variable    | Type     | Value
                ------------------------------
                self        | MixedF...| *------\
                whole_num   | int      | 1      |
                numerator   | int      | 1      |
                denominator | int      | 2      |
                                                |
        /---------------------------------------/
        |
        V
    <MixedFraction> object #1:
            Variable    | Type     | Value
            ------------------------------

When its constructor begins executing, we calculate a `new_num` value
that represents the whole number added back into the fraction's numerator.

    Method call-> MixedFraction.__init__(*, 1, 1, 2):
                Variable    | Type     | Value
                ------------------------------
                self        | MixedF...| *------\
                whole_num   | int      | 1      |
                numerator   | int      | 1      |
                denominator | int      | 2      |
                new_num     | int      | 3      |
                                                |
        /---------------------------------------/
        |
        V
    <MixedFraction> object #1:
            Variable    | Type     | Value
            ------------------------------

Alright, now things get cray cray. We make a call to `super()`, and then
use the dot notation on that? What the...?

Since it is just a function call, what does `super()` return?  Well,
that's for another discussion, but it returns something we can just call
the "super object". The super object is an object that we can ask, just
as before, execute methods for us using methods *from the superclass of
the object we are in*. It allows us to call methods that exist in both
the class and the class inherited from.

In this instance, `super()` can basically operate as an alias for
`Fraction`, and as a way to tell Python how to use methods we have two of,
such as the constructor.

So, we make the call to the constructor of `Fraction`:

    Method call-> MixedFraction.__init__(*, 1, 1, 2):
                Variable    | Type     | Value
                ------------------------------
                self        | MixedF...| *----------\
                whole_num   | int      | 1          |
                numerator   | int      | 1          |
                denominator | int      | 2          |
                new_num     | int      | 3          |
                                                    |
    Method call----> Fraction.__init__(self, 3, 2)  |
                    Variable    | Type     | Value  |
                    ------------------------------  |
                    self        | MixedF...| *------+
                    numerator   | int      | 3      |
                    denominator | int      | 2      |
                                                    |
        /-------------------------------------------/
        |
        V
    <MixedFraction> object #1:
            Variable    | Type     | Value
            ------------------------------

Now we begin execution of the constructor of `Fraction`. Notice now how
the self within its environment is the `MixedFraction`! Baller! It
completes and is destroyed, leaving us this:

    Method call-> MixedFraction.__init__(*, 1, 1, 2):
                Variable    | Type     | Value
                ------------------------------
                self        | MixedF...| *----------\
                whole_num   | int      | 1          |
                numerator   | int      | 1          |
                denominator | int      | 2          |
                new_num     | int      | 3          |
                                                    |
        /-------------------------------------------/
        |
        V
    <MixedFraction> object #1:
            Variable    | Type     | Value
            ------------------------------
            numerator   | int      | 3
            denominator | int      | 2
            to_float    | function |

Anywhozzles, once the constructor of `MixedFraction` completes, we are
left with an environment that looks like this:

    global:
            Variable        | Type     | Value
            ----------------------------------
            Fraction        | class    |
            MixedFraction   | class    |
            one_and_a_half  | MixedF...| *------\
                                                |
        /---------------------------------------/
        |
        V
    <MixedFraction> object #1:
            Variable    | Type     | Value
            ------------------------------
            numerator   | int      | 3
            denominator | int      | 2
            to_float    | function |

Cool, right? Okay, my sandwich is here. Time to go. Until next time...
