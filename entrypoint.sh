#!/bin/bash

pdf=$2
template=$3
if [ -f $1 ]
then
    if [ -z $template ]
    then
        echo "::group::Ipynb -> Pdf"
        echo "No template"
        jupyter nbconvert --to=pdf --TemplateExporter.exclude_input=True $1
        echo "::endgroup::"
    else
        workingDir=$(dirname $1)
        ipynb=$(basename $1)
        ipynbName="${ipynb%.*}"
        echo "::group::Ipynb -> Latex"
        echo "Using $3 as latex template"
        jupyter nbconvert --to=latex --LatexExporter.template_file=$3 --TemplateExporter.exclude_input=True $1
        echo "::endgroup::"
        echo "::group::Latex -> Pdf"
        cd $workingDir && pdflatex $ipynbName.tex -halt-on-error && mv $ipynbName.pdf $2.pdf
        echo "::endgroup::"
    fi
else
    echo "::error ::$1 source file not found"
    exit 1
fi