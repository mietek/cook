-- 1. Introduction
-- This little paper describes how to implement the λ-calculus in four different ways.
-- To be precise, it shows how to implement the functions that compute the (beta)
-- normal form of an expression.

module Main where
  
-- 2. Preliminaries
-- 2.1 Lambda
-- The Lambda module implements a simple abstract syntax for the λ-calculus
-- together with a parser and a printer for it.  It also exports a simple type of
-- identifiers that parse and print in a nice way.

import Lambda

-- 2.2 IdInt
-- A fast type of identifiers, Ints, for λ-expressions.

import IdInt

-- 3. Naive Substitution
-- The Simple module implements the normal form function by using a naive
-- version of substitution.

import qualified Simple

-- 4. The Barendregt Convention
-- The Unique module implements the normal form function by using Barendregt's
-- variable convention, i.e., all bound variables are unique.

import qualified Unique

-- 5. Higher Order Abstract Syntax
-- The HOAS module implements the normal form function by using higher order
-- abstract syntax for λ-expressions.  This makes it possible to use the native
-- substitution of Haskell.

import qualified HOAS

-- 6. De Bruijn Indices
-- The DeBruijn module implements the normal form function by using De Bruijn indices.

import qualified DeBruijn

-- 7. Tasting Time
-- Finally, we want to try out the different implementations.  To this end we have
-- a simple main program to pick which normal form function to use.

import Misc

main :: IO ()
main =
    interactArgs $ \args ->
      (++ "\n") . show . myNF args . toIdInt . f . read
  where
    f :: LC Id -> LC Id
    f e = e
    myNF ["S"] = Simple.nf
    myNF ["U"] = Unique.nf
    myNF ["H"] = HOAS.nf
    myNF ["D"] = DeBruijn.nf
