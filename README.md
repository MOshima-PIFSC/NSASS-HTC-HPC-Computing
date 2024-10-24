# NSASS-HTC-HPC-Computing

This repository contains examples and documentation for accessing and applying existing research computing resources available to NOAA Fisheries staff. Relevant resources and examples are documented on the repo's [webpage](https://moshima-pifsc.github.io/NSASS-HTC-HPC-Computing/), and were presented as a part of the National Stock Assessment Seminar series.

## Rendering and publishing

Rendering and publishing of the repo [webpage](https://moshima-pifsc.github.io/NSASS-HTC-HPC-Computing/) is done automatically via GitHub Actions. In order to render a local version of the webpage, clone the repo to your local machine, ensure [Quarto](https://quarto.org/docs/get-started/) is installed and run
```
quarto render
```
from a Terminal window opened in the project directory. The locally rendered webpage will be located in the `_site/` directory and can be accessed by opening `_site/index.html` in the browser of your choice. Note that the [embedio](https://quarto.thecoatlessprofessor.com/embedio/) Quarto extension is used to embed the presentation slides into the webpage. This extension is distributed with the repository however if the webpage does not render properly this extension may need to be installed.

## Github Disclaimer

This repository is a scientific product and is not official communication of the National Oceanic and Atmospheric Administration, or the United States Department of Commerce. All NOAA GitHub project code is provided on an ‘as is’ basis and the user assumes responsibility for its use. Any claims against the Department of Commerce or Department of Commerce bureaus stemming from the use of this GitHub project will be governed by all applicable Federal law. Any reference to specific commercial products, processes, or services by service mark, trademark, manufacturer, or otherwise, does not constitute or imply their endorsement, recommendation or favoring by the Department of Commerce. The Department of Commerce seal and logo, or the seal and logo of a DOC bureau, shall not be used in any manner to imply endorsement of any commercial product or activity by DOC or the United States Government.
