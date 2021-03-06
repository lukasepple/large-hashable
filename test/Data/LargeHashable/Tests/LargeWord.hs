{-# OPTIONS_GHC -F -pgmF htfpp #-}
module Data.LargeHashable.Tests.LargeWord where

-- keep imports in alphabetic order (in Emacs, use "M-x sort-lines")
import Data.LargeHashable.LargeWord
import Data.LargeHashable.Tests.Helper ()
import Test.Framework
import qualified Data.ByteString as BS

prop_w128BsHasLength16 :: Word128 -> Bool
prop_w128BsHasLength16 x = BS.length (w128ToBs x) == 16

prop_conversionFromAndToWord128 :: Word128 -> Bool
prop_conversionFromAndToWord128 h128 = h128 == bsToW128 (w128ToBs h128)

prop_conversionFromAndToWord256 :: Word256 -> Bool
prop_conversionFromAndToWord256 h256 = h256 == bsToW256 (w256ToBs h256)

test_bsToW128 :: IO ()
test_bsToW128 =
    do assertEqual (Word128 0 0) (bsToW128 BS.empty)
       assertEqual (bsToW128 (BS.pack ([0,0,0,0,0,0,0,1] ++ replicate 8 0))) (bsToW128 (BS.pack [1]))
       assertEqual (bsToW128 (BS.pack ([1,2,3,4,5,6,7,8,0,0,0,0,0,0,0,9])))
           (bsToW128 (BS.pack [1,2,3,4,5,6,7,8,9]))
