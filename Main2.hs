{-# LANGUAGE OverloadedStrings, RecordWildCards #-} 

module Main where
import Data.ByteString (ByteString)
import Data.Conduit
import Data.Conduit.Binary (sourceHandle, sinkHandle)
import Data.Conduit.List as CL
import Data.CSV.Conduit
import Data.Text (Text)
import System.Environment
import System.IO (stdout, stdin, Handle, openFile, IOMode(..))
import Options.Applicative
import Control.Applicative

process :: Monad m => Conduit (Row Text) m (Row Text)
process = CL.map id

data Conf = Conf {
    delimiter :: Char
  , source :: String
  }

main :: IO ()
main = do
  Conf{..} <- execParser opts
  let inDSVSettings = CSVSettings delimiter Nothing
  source' <- case source of
              "-" -> return stdin
              f -> openFile f ReadMode
  runResourceT $ 
      transformCSV' 
                  inDSVSettings
                  defCSVSettings 
                   (sourceHandle source') 
                   process
                   (sinkHandle stdout)

opts = info (helper <*> parseOpts)
          (fullDesc 
            <> progDesc "Converts DSV to CSV format"
            <> header "dsv2csv"
            <> footer "See https://github.com/danchoi/csv2dsv for more information.")

parseOpts :: Parser Conf 
parseOpts = Conf 
    <$> (Prelude.head <$>  
          strOption (value "\t" 
                <> short 'd'
                <> long "delimiter"
                <> metavar "CHAR"
                <> help "Delimiter characters of DSV input. Defaults to \\t."))
    <*> strArgument (metavar "FILE" <> help "Source DSV file. '-' for STDIN")
   



