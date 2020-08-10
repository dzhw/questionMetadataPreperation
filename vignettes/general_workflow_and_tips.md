---
title: "Surrounding Workflow and Hints&Tips"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteIndexEntry{Surrounding Workflow and Tips}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---

# Introduction

The destination format of question metadata consists of question JSONs, question-images (in png format) and, question image JSONs. Since this is the question metadata in the format needed for uploading it to the [metadata management system](https://metadata.fdz.dzhw.eu) (abbreviated mdm), it is called "mdm" format.
In order to generate metadata in this format, one ﬁrst needs to work in the "handcrafted format". The handcrafted format can either be generated from scratch or if the data was collected using DZHW's online questionnaire tool `Zofar`, `questionMetadataPreparation` contains a routine to transform
metadata extracted by `Zofar` to the *handcrafted* format.
In any case, the files have to be converted from the handcrafted format to the mdm format.
After uploading to the metadata management system, the metadata must be checked.

# From *Zofar* to *handcrafted*

*Skip this section if the data was not collected using Zofar.*

## Request Metadata from Zofar
As soon as you start working on a data preparation project for which the data was generated using Zofar, contact the Zofar team by creating a [new issue](https://github.com/dzhw/zofar/issues/new) and ask for question metadata. Keep in mind that Zofar works in sprints, which means that if you miss to write down the issue before their planning meeting, they will consider it at the sprint afterwards at the earliest (possibly later due to other issues their product owner considers to be of higher priority).
The Zofar team needs to know the following (example in brackets):
 - `dataAcquisitionProjectId` (`nac2018`)
 - `studyId` (`stu-nac2018`)
 - `instrumentIds` (`ins1` (`ins-nac2018-ins1`))
 - `dataSetIds` (`ds1` (`dat-nac2018-ds1`))

## Check and prepare metadata for transforming them from Zofar format to handcrafted format

After they send you the metadata, you need to have a look at the following variables inside the question jsons and have a look at the question images. If there’s something wrong, you can decide whether to just edit it or (better) provide feedback to Zofar so that it does not happen in future metadata deliveries again.
The following variables deserve special attention:
 - conceptIds (need to be added by you and cannot be delivered by Zofar)
 - instrumentNumbers/instrumentIds
 - surveryNumbers/surveyIds
 - questionNumber
 
You need to check whether everything that was multilingual is present in all languages that were shown to the respondent.
Check that all mandatory ﬁelds are filled in.
The images need to look like the participants of the study saw the study. Images should be available for all languages. Check that the images fit to the json - there was a case once where one image was repeatedly present for multiple questions.

## File management and use of `questionMetadataPreparation`

The question metadata in the Zofar format needs to *always* be transformed into the handcrafted format.

Copy the ﬁles into the project directory on Faust.
In order to convert the metadata from the *Zofar* format to the *handcrafted format* which can be manually edited, you can use the R package `questionMetadataPreparation`.

You need to use the metadata from the `pages` directory and *not* from the `questions` directory. The data in the `pages` directory corresponds to our model of a question. Zofar will nevertheless also ship a `questions` directory, which contains questions that are built up from multiple parts (e.g. a single choice item and a free form answer) that are split up into their individual parts.

In order to convert the questionmetadata from the handcrafted format to the Zofar format, you need to use the following function


```r
convert_handcrafted_questionnaires_to_mdm_format(input_directory = "./questions", output_directory = "./output/questions", images_subdirectory = "Bilder/png")
```

For further information on this function please refer to the section in the [manual](https://dzhw.github.io/questionMetadataPreparation/reference/convert_zofar_export_to_handcrafted_questionnaire.html).

After the conversion from the Zofar format to the handcrafted format, they need to be adapted manually (hence the name handcrafted), because Zofar does not have all required information in advance.


# From *handcrafted* format to *mdm* format

*You will always have to follow the following steps*

The `handcrafted` format consists of an excel file and possibly question-image files which are not mandatory. 

## Excel file

The excel file `questions.xlsx` contains the sheets "questions" and "images".

### Filling out the `questions` sheet

+------------------------+-----------------------+------------------------+
| **Sheet 1: questions**                                                  |
+========================+=======================+========================+
| You can enter more than|                       |                        |
| one questions, one per |                       |                        |
| row                    |                       |                        |
+------------------------+-----------------------+------------------------+
| **Columnheading**      | **Mandatory**         | **What needs to be     |
|                        |                       |entered?**              |
+------------------------+-----------------------+------------------------+
| indexInInstrument      | yes                   | Number of the question |
|                        |                       | in the questionnaire,  |
|                        |                       | which specifies the    |
|                        |                       | order (integer)        |
+------------------------+-----------------------+------------------------+
| questionNumber         | yes                   | Questionnumber,        |
|                        |                       | ideally self           |
|                        |                       | explanatory; derived   |
|                        |                       | from the instrument    |
|                        |                       | (e.g. 1.1)             |
|                        |                       | Format: 0-9,           |
|                        |                       | a-z, umlauts, ß, ., -  |
+------------------------+-----------------------+------------------------+
| instrumentNumber       | yes                   | Number of the          |
|                        |                       | [instrument](https://metadatamanagement.readthedocs.io/de/latest/metadatenabgabe.html#erhebungsinstrumente-instruments)             |
+------------------------+-----------------------+------------------------+
| successorNumbers       | no                    | questionNumbers of the |
|                        |                       | following question(s)  |
|                        |                       | (one row, comma        |
|                        |                       | separated)             |
+------------------------+-----------------------+------------------------+
| questionsText.de/en    | yes                   | "Overarching"          |
|                        |                       | question text if       |
|                        |                       | there's a battery of   |
|                        |                       | items; introducing     |
|                        |                       | question text in case  |
|                        |                       | of complex questions.  |
|                        |                       | The complete question  |
|                        |                       | text for simple        |
|                        |                       | questions.             |
+------------------------+-----------------------+------------------------+
| instruction.de/en      | no                    | If available, statement|
|                        |                       | text of the question   |
+------------------------+-----------------------+------------------------+
| introduction.de/en     | no                    | If available,          |
|                        |                       | introductory text of   |
|                        |                       | the question           |
+------------------------+-----------------------+------------------------+
| type.de/en             | yes                   | de: "Einfachnennung",  |
|                        |                       | "Offen",               |
|                        |                       | "Mehrfachnennung",     |
|                        |                       | "Itembatterie" oder    |
|                        |                       | "Matrix" (a manual of  |
|                        |                       | the different types    |
|                        |                       | can be found           |
|                        |                       | [here][typelink])      |
|                        |                       |                        |
|                        |                       | en: "Single Choice",   |
|                        |                       | "Open", "Multiple      |
|                        |                       | Choice", "Item Set"    |
|                        |                       | or "Grid".             |
+------------------------+-----------------------+------------------------+
| topic.de/en            | no                    | Theme block in which   |
|                        |                       | the question is        |
|                        |                       | arranged in the        |
|                        |                       | instrument (ideally, it|
|                        |                       | can be taken directly  |
|                        |                       | from the instrument).  |
+------------------------+-----------------------+------------------------+
| technicalRepresentati\ | x\*                   | Origin of the code     |
| ion                    |                       | snippet (e.g. "ZOFAR-\ |
|                        |                       | Question Markup        |
|                        |                       | Language")             |
+------------------------+-----------------------+------------------------+
| technicalRepresentati  | x\*                   | Technical language of  |
| on.language            |                       | the code snippet       |
|                        |                       | (e.g. XML)             |
+------------------------+-----------------------+------------------------+
| technicalRepresentati\ | x\*                   | Code snippet to        |
| on.source              |                       | technically map        |
|                        |                       | questions              |
|                        |                       | (e.g. QML-snippet)     |
+------------------------+-----------------------+------------------------+
| additionalQuestionTex\ | no                    | Further explanations of|
| t.de/.en               |                       | the question that are  |
|                        |                       | not in the question    |
|                        |                       | text, such as the item |
|                        |                       | text (for item         |
|                        |                       | batteries) or answer   |
|                        |                       | text (for multiple     |
|                        |                       | answers). Currently,   |
|                        |                       | this information is not|
|                        |                       | visible to the user of |
|                        |                       | the MDM, but is only   |
|                        |                       | considered in a full   |
|                        |                       | text search.           |
+------------------------+-----------------------+------------------------+
| annotations.de/en      | no                    | Comments on the        |
|                        |                       | question               |
+------------------------+-----------------------+------------------------+
| conceptIds             | no                    | List of IDs of concepts|
|                        |                       | in the MDM (comma      |
|                        |                       | separated on one line  |
+------------------------+-----------------------+------------------------+

x\* = mandatory only, if technicalRepresentation present (it's provided by 
Zofar)

It could make sense to try out whether OCR is helpful in order to avoid typing everything and to just copy and paste. If you want to use OCR, scan the document in a the highest possible resolution without compression. It could be helpful to sharpen the pdf or employ other means to increase readability. Try out diﬀerent OCR tools, as many of them are slightly diﬀerent and give different results. Adobe Acrobat PRO is a commonly used option.

### How to ﬁll in the excel sheet "images"

You need to fill the images spreadsheet only if there are images. 
However, the columns need to be present always. 

+------------------------+----------------------+-----------------------+
| **Excel sheet   2:                                                    |
| images**                                                              |
+========================+======================+=======================+
| You can enter more than                                               |
| one image, one image                                                  |
| per row                                                               |
+------------------------+----------------------+-----------------------+
| **Columnheading**      | **Is it mandatory?   | **What do I need to \ |
|                        |                      | fill in?**            |
+------------------------+----------------------+-----------------------+
| fileName               | yes                  | File name of the image|
|                        |                      | (e.g. "1.1_1.png") The|
|                        |                      | image is then expected|
|                        |                      | in "./Bilder/png/ins" |
|                        |                      |+ "{instrumentNumber}/"|
+------------------------+----------------------+-----------------------+
| questionNumber         | yes                  | Question number       |
|                        |                      | assigned to the image |
+------------------------+----------------------+-----------------------+
| instrumentNumber       | yes                  | Number of the         |
|                        |                      | instrument belonging  |
|                        |                      | to the image          |
+------------------------+----------------------+-----------------------+
| language               | yes                  | Language of the image |
|                        |                      |                       |
|                        |                      | *Please abbreviate    |
|                        |                      | according to          |
|                        |                      | ISO [639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes):          |
|                        |                      | e.g. "de", "en"       |
+------------------------+----------------------+-----------------------+
| indexInQuestion        | yes                  | How many pictures of  |
|                        |                      | the question does the |
|                        |                      | line refer to? (If    |
|                        |                      | there is only one     |
|                        |                      | picture per question, |
|                        |                      | this is always 1)     |
+------------------------+----------------------+-----------------------+
| resolution.widthX      | no                   | Resolution of the     |
|                        |                      | image in pixels       |
+------------------------+----------------------+-----------------------+
| resolution.heightY     | no                   | Resolution of the     |
|                        |                      | image in pixels       |
+------------------------+----------------------+-----------------------+

In case you have question images, you need to fill the second sheet of the excel 
file. The images have to be PNG files and need to be put in the subdirectory
"./Bilder/png/ins{instrumentNumber}".

The files need to be stored as follows:

```
|--questions
  |--questions*.xlsx (two sheets, questions and images)
  |--Bilder
    |--png
      |--ins1
        |--5_1.png (must match the filename in the images excel sheet)
        |--5_2.png (must match the filename in the images excel sheet)
      |--ins2
        |--5_1.png (must match the filename in the images excel sheet)
        |--5_2.png (must match the filename in the images excel sheet)
```

# Check Question Metadata and images

The easiest ways to check the question metadata are either to check them at the handcrafted stage or after they are uploaded to the mdm. If there's something wrong, you can decide whether to just edit it or (better) provide feedback to Zofar if the issue was not caused by us so that it does not happen in future metadata deliveries again.

RDC-researcher: \

 - If there are questions which should not be imported in the mdm, check whether these are truly not imported.
 - Check the question types.
 - Check whether the conceptIds are present.

RDC-student employee: \

 - Click through the mdm to see whether the appropriate images are shown and whether the content is correct (the latter could also be checked in the excel ﬁle). Double check with the screenshot document (English and German).
 - If there are ﬁelds which are not displayed (additionalQuestionText.de, additionalQuestionText.en), you can check them by clicking on the curly braces button in the mdm. Double check with the excel ﬁle questions-insX.xlsx.
 - If question metadata were not delivered by Zofar, please double check spelling.
 - Make sure questions and variables are linked correctly.
 - Make sure the order in the MDM is the same as in the questionnaire.
 - Do not edit the jsons that are imported, but edit the handcrafted xlx ﬁle
 - The images need to look like the participants of the study saw the study. 
 - Images should be available for all languages.
 - Check whether questions that were deleted (if any) are really deleted


# FAQ/Troubleshooting

## In what order do I need to use the R functions?

As it came up often: You *always* need to transform the handcrafted format to the mdm format. If you get questionMetadata from Zofar, you first need to transform the metadata from the Zofar format to the handcrafted format and then to the mdm format.


## I cannot open an excel file from Zofar

Check that you use utf-8.
Sometimes the chararacters are not escaped properly. 
This needs to be altered on a case to case basis. Look out for special characters (ä,ö,ü,ß, brackets etc).

# Preload variables

As it stands now, we do not edit preload variables.

# Some hints for new R users

- Check if your R version and the libraries are up to date.
- If you use windows, install the [Rtools](https://cran.r-project.org/bin/windows/Rtools/) and check that you use the version that corresponds to your R version.
- Check whether you have the appropriate version or Rtools installed and whether R can find it.
- You could change the working directory using `setwd()`. If you are unsure what your working directory is, use `getwd()`
- However, usually you *don't* want to use `getwd()` but work in a project manner. You'll need the package/library `here`, as this makes the code independent of your computers directory structure. For more details and background, see [here](https://github.com/jennybc/here_here).
- Paths on windows need to be escaped, ie. `\` becomes `\\`. To make it easier, here's an Rscript for that. Simply copy the path to your clipboard (ctrl + c) and then run the function as `pathPrep()`. Source: https://stackoverflow.com/a/8425591]


```r
pathPrep <- function(path = "clipboard") {
    y <- if (path == "clipboard") {
        readClipboard()
    } else {
        cat("Please enter the path:\n\n")
        readline()
    }
    x <- chartr("\\", "/", y)
    writeClipboard(x)
    return(x)
}
```
Or you could replace `\` with `/`

# Usefull links, further documentation

- [readthedocs](https://metadatamanagement.readthedocs.io/de/stable/questions.html)
- [Github repository](https://dzhw.github.io/questionMetadataPreparation/index.html) and the - [introduction how to use questionMetadata Preparation](https://dzhw.github.io/questionMetadataPreparation/articles/question_metadata_preparation_introduction.html)