% Generated by roxygen2: do not edit by hand
% Please edit documentation in
%   R/convert_zofar_export_to_handcrafted_questionnaire.R
\name{convert_zofar_export_to_handcrafted_questionnaire}
\alias{convert_zofar_export_to_handcrafted_questionnaire}
\title{Convert Zofar Export to Handcrafted Questionnaire Format}
\usage{
convert_zofar_export_to_handcrafted_questionnaire(
  input_directory,
  output_directory = file.path(".", "handcrafted", "pages")
)
}
\arguments{
\item{input_directory}{Input path, e.g. "./pages/ins1", must contain
"ins\{number\}"}

\item{output_directory}{Output directory, e.g. "./handcrafted/pages",
will be created if it does not exist or will be overwritten otherwise}
}
\description{
This script takes the export of zofar and converts it into a format which can
be manually edited. The zofar export must have the following structure:
\preformatted{
|--ins1 (must have the pattern "ins\{number\}")
  |--5.json
  |--images
     |--5
        |--5_1.png
        |--5_1.json
        |--5_2.png
        |--5_2.json
        |--5_3.png
        |--5_3.json
}
The output directory will be created or overwritten.
}
\examples{
\dontrun{
# All examples do exactly the same. They convert everything under "./ins1"
# into the handcrafted format and write the output in "./handcrafted/pages".
convert_zofar_export_to_handcrafted_questionnaire(input_directory = "./ins1")
convert_zofar_export_to_handcrafted_questionnaire(input_directory = "./ins1", output_directory = "./handcrafted/pages")
}
}
