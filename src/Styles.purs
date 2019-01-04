module ExamSearch.Styles where

import Prelude

import CSS (CSS, backgroundColor, display, fontSize, inline, inlineBlock, margin, marginLeft, marginRight, marginTop, padding, paddingTop, px, rgb, white, width)
import CSS.TextAlign (textAlign, center)

header :: CSS
header = do
  margin (px 0.0) (px 0.0) (px 0.0) (px 0.0)
  padding (px 10.0) (px 10.0) (px 10.0) (px 10.0)
  textAlign center 
      
headerTitle :: CSS
headerTitle = do
  display inlineBlock
  margin (px 0.0) (px 0.0) (px 0.0) (px 0.0)
      
content :: CSS
content = do
  padding (px 10.0) (px 10.0) (px 10.0) (px 10.0)
  marginTop (px 30.0)
  textAlign center 

date :: CSS
date = do
  marginRight (px 5.0)
  marginLeft (px 5.0)
  fontSize (px 12.0)
  textAlign center 

divider :: CSS
divider = do
  marginLeft (px 4.0)
  marginRight (px 4.0)

sort :: CSS
sort = do
  display inline
  fontSize (px 18.0)
  marginLeft (px 10.0)

selected :: CSS
selected = do
  display inline
  fontSize (px 18.0)
  marginLeft (px 10.0)
  padding (px 4.0) (px 4.0) (px 4.0) (px 4.0)
  backgroundColor white
      
unselected :: CSS
unselected = do
  display inline
  fontSize (px 18.0)
  marginLeft (px 10.0)
