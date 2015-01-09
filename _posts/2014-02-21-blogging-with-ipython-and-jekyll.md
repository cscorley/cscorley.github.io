---
layout: post
title: "Blogging with IPython and Jekyll"
tags:
    - python
    - notebook
---
Lately I've been using [IPython][] to do most of my tinkering work.
It's pretty neat, to say the least.

I've seen around the Internet people using IPython as a way to blog.
I thought that this would be a pretty neat way to go about things, and
probably save a large amount of time on editing code-centric blog posts.
However, the methods I found were either outdated,
outputted HTML (usually with gross CSS conflicts),
were hacks for other blogging software, or required a plugin.

Since I use [Github Pages][] (read: [Jekyll][]) to auto-render my blog, I
decided to
code up my own method.
My method outputs files that are in Markdown with a Jekyll front matter pre-
filled.
This way, I can still add blog posts in the same format as before and edit if
needed.
No plugins are required this way, too. Sure, it is manual conversion of
notebooks, but
that's pretty much the only way to get around the plugin issue *and* still be
able to use Github Pages.

[IPython]: http://ipython.org/
[Github Pages]: http://pages.github.com/
[Jekyll]: http://jekyllrb.com/

Here are the files you will need to publish a notebook to Jekyll: [https://gist.
github.com/cscorley/9144544](https://gist.github.com/cscorley/9144544)

* `jekyll.py`: This is the config file used for conversion. It should be placed
wherever the profile you are using is. Default is `~/.ipython/profile_default/`
* `jekyll.tpl`: I plop all my template files into `~/.ipython/templates`, but
put `jekyll.tpl` wherever suits you best (just be sure to change the jekyll.py
to point to that location, also)

Everything will output into a folder named `notebooks`.
You can change this by replacing in the config all instances of 'notebooks' with
whatever you want.

There is one variable in the config named `BLOG_DIR`
that is used to automatically generate the markdown
and any support files the notebook needs into this directory.
Right now it reads from the environment variable of the same name.
You will need to export a `$BLOG_DIR` environment variable to be able to use
this script as-is.
This is important because the configuration file `jekyll.py` will use this
variable unless the configuration is changed.
If you just want them to plop into the current directory, change it in the
config to an empty string.

Finally, you can now run your conversion *on a single file* with the command:
`ipython nbconvert --config jekyll.py <FILENAME>`.

I did this whole `$BLOG_DIR` and `notebooks` mess because Jekyll was pooping out
whenever a markdown file appeared in the notebooks folder I was using. I also
wanted the notebooks folder so nbconvert would know where to place any support
files, and that Jekyll would blindly copy these into the generated site. Plus, a
place to put the notebook files themselves so they can be [downloaded
directly](/notebooks/Blogging with IPython and Jekyll.ipynb)! Nice, yeah?

Here's a shell function I wrote to convert a notebook file and then move any
markdown files created into the `_drafts` folder.

    export BLOG_DIR="/Users/cscorley/git/cscorley.github.io"
    nbconvert(){
        ipython nbconvert --config jekyll.py $@;
        find ${BLOG_DIR}/notebooks/ -name '*.md' -exec mv {} ${BLOG_DIR}/_drafts/ \;
        cp $@ ${BLOG_DIR}/notebooks/
    }

That's all. I just do `nbconvert FILE` now and it just works. Jekyll doesn't
kill itself over it. When I'm done checking that the post is ready to go live, I
move it into the `_posts` folder. No big deal, right?


Below is some example code!

**In [1]:**

{% highlight python %}
class Pizza:
    def __init__(self, toppings):
        self.toppings = toppings
        
    def is_yummy(self):
        return True

p = Pizza(['pineapple', 'cheese'])
print(p.is_yummy())
{% endhighlight %}

    True


**In [2]:**

{% highlight python %}
%pylab inline
{% endhighlight %}

    Populating the interactive namespace from numpy and matplotlib


Some code copied from [Wikipedia](https://en.wikipedia.org/wiki/Matplotlib):

**In [3]:**

{% highlight python %}
>>> import matplotlib.pyplot as plt
>>> import numpy as np
>>> a = np.linspace(0,10,100)
>>> b = np.exp(-a)
>>> plt.plot(a,b)
>>> plt.show()
{% endhighlight %}


![png]({{ site.baseurl}}notebooks/blogging-with-ipython-and-jekyll_files/blogging-with-ipython-and-jekyll_4_0.png)

