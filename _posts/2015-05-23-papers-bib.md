---
layout: post
title: "papers.bib or: How I Learned to Stop Worrying and Love the Reference
        Manager"
tags:
    - writing
    - references
    - bibliography
    - bibtex
    - jabref
---

I recently completed and passed my phd thesis proposal. During my time
struggling to get myself together and organized, I gave up on trying to manage
BibTeX file by hand. Here, I'm going to describe the software and strict
workflow I've been using to manage a single thesis bibliography, `papers.bib`.

My criteria were the following:

1. Cross-platform
2. Open source as heck
3. Keeps all machines in sync
4. Easy to restore an old version
5. On-demand opening/viewing of the source PDF
6. Usable *offline*

# Software

I use three primary programs to manage my `papers.bib` file:

1. [JabRef](http://jabref.sourceforge.net/)
    - I chose JabRef as the reference manager because it is open source,
      cross-platform, and can open PDFs or URLs directly.
    - As an added plus, it has support for plugins and a BibTeX downloader.

2. [git](http://git-scm.com/)
    - git was the obvious choice for versioning of the `papers.bib`.
    - Easy to back up on Github/Bitbucket/whatever.

3. [Syncthing](https://syncthing.net/)
    - Syncthing was chosen because it was a solid open-source replacement for
      Dropbox.
    - Used for keeping previously downloaded PDF files in sync.

I can satisfy all my criteria with a combination of these three tools.


## Setup

The first thing I do (did?) is to start a git repository in `~/papers/`. In
this folder I place my main `papers.bib` file for JabRef to manage.

### JabRef

There's only one essential configuration option I rely on: the BibTeX key
generator. In JabRef's preferences, I set the default pattern to be
`[auth.etal]_[year]`. You can use whatever you fancy, but be sure to use
something with file system safe characters (e.g., avoid special characters like
`:`).

### Syncthing

I set up `~/papers` for syncing within Syncthing. In Syncthing, you can set up
*ignore patterns* for files it should ignore during sync. I use these:

```
.git
.git*
papers.bib
```

This means it will skip git-related stuff and the main `papers.bib`, but `git`
will take care of all of those.

### git

Likewise, I set git up to ignore the PDF files by placing this into the
`.gitignore`: `*.pdf`. Syncthing will be managing those PDFs.

# Workflow

When I run across a paper I want to cite, or even *read*, I download all of the
following:

1. BibTeX: sometimes I copy in an entry directly from the web source, and other
   times I use the JabRef web search & downloading feature. *Very rarely* have
   I needed to make entries manually. Manual entries are usually theses or
   books.

2. DOI/URL: All papers must have the DOI or URL. If I by chance lose a PDF, I
   can find the original source again.

3. PDF: Every paper must have the PDF associated with it. The only exception
   are library sources, which *if possible* I will make sure the URL points to
   the library online catalog entry or a place to buy it online (Amazon).

Once the BibTeX is in JabRef, the first thing I make sure to do is insert the
DOI/URL if it doesn't already have one. One thing I noticed is that sites like
[IEEEXplore][] don't include the DOI in the downloaded BibTeX, but list it on
the paper's web page. I make sure to grab that.

[IEEEXplore]: http://ieeexplore.ieee.org

The second thing I do is attach the PDF file. If you right click an entry,
"Attach file" will be in the menu. Normally, the downloaded PDF name is
horrible and gross. Hence, I use a handy plugin to help with that.

## renameFile

There's a plugin that is critical for my JabRef use: [renameFile][].

renameFile comes with two configuration options: folder and name pattern. I use
both, leaving the "folder" blank (i.e., it uses whatever directory `papers.bib`
is in to place PDFs). Because of the way we've configured JabRef's key
generation option, I leave the name pattern as `[bibtexkey]`.

After attaching a file, I simply hit "rename" in the plugin window, verify the
file is being renamed as expected, and I'm done. It will rename the PDF file to
match the BibTeX key and move the file to the `~/papers/` folder. Yay!

[renameFile]: https://github.com/korv/Jabref-plugins

## git commit

After I finish up adding new sources or finish writing for the day, I make sure
to check in the `papers.bib` file into git. When committing, ***I always check
the `git diff` to make sure nothing was removed, only added***. That last bit
is critical, cause it can tell you when something is amiss. I also push the
changes to a public-facing [Github repository][].

[Github repository]: https://github.com/cscorley/papers

# Writing and collaboration

Having a single, dedicated `papers.bib` comes with one major caveat when trying
to collaborate: people are going to insert things into the *working
bibliography*, hence breaking the workflow of the *central bibliography*
entirely! Not sure there's much to do about that, but here's my current
workaround.

Each paper I work on has it's own separate git repo. I always merge in my
`papers.bib` file as the "main" source and check it into git. That means *git
is managing two separate versions of the "same file" in two separate repos*,
which can certainly be confusing. Luckily, `diff` makes it easy to determine
the differences between the working and central bibliographies.

Whenever someone makes a change to the working bibliography, I make sure to
*immediately* merge the new entries into my central bibliography by following
the workflow I describe above. If it is going to be in a paper with my name in
it, I am going to have it for future reference. I do this by literally checking
`diff -us ~/papers/papers.bib path/to/collab/papers.bib` manually every time I
begin writing. I know, this part sucks. You could also make sure by checking
`git whatchanged` after a `git pull`.

After the new changes are merged into the central bibliography, I overwrite the
working one with the central one. This ensures I can see whenever a change is
introduced after I add in the DOI, URL, or PDF fields.

# Summary

I know that seems like a lot of work -- oh, it is -- but trust me, it becomes
so much easier to use after it is setup and working.  Be vigilant in
maintaining it and future you will thank you for having a central source for
the references, along with links and PDFs.

One immediate need I've noted has to do with collaboration. While the workflow
worked really well for my proposal as I was the only one working on it,
collaboration immediately exposed flaws. For now, I'm manually working around
this limitation.

