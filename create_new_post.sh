#!/usr/bin/env sh
title=$1
if [ -z $1 ]; then
    title="untitled"
fi

filename=_posts/`date --rfc-3339=date`-${title}.md
if [ -e $filename ]; then
    echo "file ${filename} already exists. "
    exit
fi

cat << EOS > $filename
---
layout: post
title:  
date:  `date --rfc-3339=date`
tags: 
---
EOS