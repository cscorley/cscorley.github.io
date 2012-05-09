{-# LANGUAGE OverloadedStrings #-}
import Hakyll
import Control.Monad (forM_)
import Control.Arrow ((>>>), arr)
import Data.Monoid (mempty)
import Text.Pandoc
import System.FilePath

main :: IO ()
main = hakyllWith config $ do
    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    -- Static directories
    forM_ ["images/*", "examples/*", "reference/**"] $ \f -> match f $ do
        route   idRoute
        compile copyFileCompiler

    -- Pages
    forM_ pages $ \p -> match p $ do
        route   $ routePage --setExtension "html"
        compile $ pageCompiler
            >>> requireA "sidebar.md" (setFieldA "sidebar" $ arr pageBody)
            >>> requireA "footer.md" (setFieldA "footer" $ arr pageBody)
            >>> applyTemplateCompiler "templates/default.html"
            >>> relativizeUrlsCompiler

    match "index.md" $ do
        route   $ setExtension "html"
        compile $ pageCompiler
            >>> requireA "sidebar.md" (setFieldA "sidebar" $ arr pageBody)
            >>> requireA "footer.md" (setFieldA "footer" $ arr pageBody)
            >>> applyTemplateCompiler "templates/index.html"
            >>> relativizeUrlsCompiler

    -- Sidebar
    match "sidebar.md" $ compile pageCompiler

    -- Footer
    match "footer.md" $ compile pageCompiler

    -- Templates
    match "templates/*" $ compile templateCompiler
  where
    withToc = defaultHakyllWriterOptions
        { writerTableOfContents = True
        , writerTemplate = "$toc$\n$body$"
        , writerStandalone = True
        }

    pages = [ "vita.md"
            , "publications.md"
            , "disclaimer.md"
            , "copyright.md"
            ]

config :: HakyllConfiguration
config = defaultHakyllConfiguration
    { 
        deployCommand = "rsync --checksum -av ./_site/* ~/Web/"
    }

-- | Take a page like @\"/about/notebooks.md\"@ and route it to
-- @\"/about/notebooks\"@, i.e. turn a filename into a drectory.
--
routePage :: Routes
routePage = customRoute fileToDirectory


-- | Turn a filename reference into a directory with an index file.
--
fileToDirectory :: Identifier a -> FilePath
fileToDirectory = flip combine "index.html" . dropExtension . toFilePath
