<!-- omit in toc -->
# Contributing to RAM Resources Scripts

Thank you for considering contributing to RAM Resources Scripts! We welcome and appreciate any contributions, whether it be code, documentation, or bug reports.

See the [Table of Contents](#table-of-contents) for different ways to help and details about how this project handles them. Please make sure to read the relevant section before making your contribution. It will make it a lot easier for us maintainers and smooth out the experience for all involved. 

## How to contribute and submit changes

1. Pick a task from the Project board or from the Issues. The tasks displayed in the board have been created and prioritized by the project members and admins.
2. Fork the repository
3. Clone the forked repository to your local machine
4. Create a new branch on your local machine with a descriptive name (e.g. fix-typo-in-documentation).
5. Make your changes in a new branch
6. Commit your changes with a clear and concise message, using conventional-changelog format. 
7. Push the changes to your forked repository. 
8. Submit a pull request to the original repository, on the **main** branch. The pull request should be self-contained, limited in scope and well-described (e.g. one pull request per indicator changed). This will speed up the review and merge process. 
9. Maintainers will review the request and merge the PR into the **main** branch. 
    
> **Note:**  Do not commit passwords or other secret/sensitive information, as they will be publicly available and can remain recorded in the GitHub history. If this happens, invalidate secrets immediately (e.g.: change password).

### Script structure
If  you're adding a new script/indicator, this should be **properly commented and organized as follows:**
1. If an environment argument is empty, ingest a sample dataset. Use relative paths (versus absolute paths such as: C:\Projects\RAMResourcesScripts\Static\Nut_CRF_7_coverage_Sample_Survey)
2. Generate new variables
3. Label and recode variables
4. Aggregate to obtain final indicator
5. Label and recode final indicator
6. Remove intermediate variables to leave a clean dataset. 
   
> **Note:** It is important that the original dataset is not replaced. Avoid replacing the original dataset and minimize read-save operations on disk.

### Sample file creation
The RAM Resource Scripts repository should have also sample files for specific indicators for experimentation and testing of the script. These should be in CSV  or SPS formats and containing no real PII. Sample files should be composed by max 30 entries and remove group and repeat prefixes. 
Each file should be named in a clear, understandable way, hinting to the intended use for that file. Alternatively, a sub-folder for a specific indicator could be created, including also a README.md explaining the use of the different files in the sub-folder.


## How to report a bug or request a new indicator

> You must never report security related issues, vulnerabilities or bugs including sensitive information to the issue tracker, or elsewhere in public. Instead sensitive bugs must be sent by email to <global.researchassessmentmonitoring@wfp.org>.

We use GitHub issues to track bugs and errors, request a new indicator or changes to an existing one or ask questions. If you run into an issue with the project:

- Open an [Issue](https://github.com/WFP-VAM/RAMResourcesScripts/issues/new/choose). 
- Choose whether you need to file a Bug report, request a new Indicator or changes to an existing one or just ask a question.
  - If it's a Bug, please provide as much context as possible and describe the *reproduction steps* that someone else can follow to recreate the issue on their own. This usually includes your code. For good bug reports you should isolate the problem and create a reduced test case.
-  If it's an Indicator, provide the name of the indicator, language/software that the indicator should be calculated in, the WFP unit that owns the indicator and whether it's part of the WFP Corporate Result Framework

Once it's filed the project team will prioritize the issue accordingly, also considering the reproducibility of the issue. 

## Styleguide for commit messages 

When committing changes, please make sure that your commit message follows this style guide:

- Start the commit message with a brief summary of the changes, written in the present tense and in imperative mood. 
- Leave a blank line after the summary.
- Add a more detailed explanation of the changes, if necessary.
- Use bullet points to list specific changes, if applicable.
- Keep the commit message concise and to the point.

**Example:**
```
Fix typo in documentation

- Change "form" to "from" in the first paragraph on page 3.
```

This format makes it easy for other contributors to understand the changes you have made and why they were made.
