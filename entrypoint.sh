#!/bin/bash

ipynb=$1
pdf=$2
template=$3
if [ -f $ipynb ]
then
    if [ -z $template ]
    then
        echo "::group::Ipynb -> Pdf"
        echo "No template"
        jupyter nbconvert --to=pdf --TemplateExporter.exclude_input=True $1 --output $2.pdf
    else
        if [ -f $ipynb ]
        then
            echo "::group::Ipynb -> Latex"
            echo "Using $3 as latex template"
            jupyter nbconvert --to=latex --LatexExporter.template_file=$3 --TemplateExporter.exclude_input=True $1 --output $2.tex
            echo "::endgroup::"
            echo "::group::Latex -> Pdf"
            pdflatex $2.tex -halt-on-error -jobname $2
        else
            echo "::error ::$template template file not found"
            exit 1
        fi
    fi
    echo "::endgroup::"
else
    echo "::error ::$ipynb source file not found"
    exit 1
fi