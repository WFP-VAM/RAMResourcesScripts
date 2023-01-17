<!-- omit in toc -->
# Contributing to RAM Resources Scripts

Thank you for considering contributing to RAM Resources Scripts! We welcome and appreciate any contributions, whether it be code, documentation, or bug reports.

See the [Table of Contents](#table-of-contents) for different ways to help and details about how this project handles them. Please make sure to read the relevant section before making your contribution. It will make it a lot easier for us maintainers and smooth out the experience for all involved. 

<!-- omit in toc -->
## Table of Contents

- [How to contribute and submit changes](#how-to-contribute-and-submit-changes)
  - [How to report a bug](#how-to-report-a-bug)
- [Styleguides](#styleguides)
  - [Commit Messages](#commit-messages)

## How to contribute and submit changes

1. Pick a task from the Project board or from the Issues. The tasks displayed in the board have been created and prioritized by the project members and admins.
2. Fork the repository
3. Clone the forked repository to your local machine
4. Create a new branch on your local machine with a descriptive name (e.g. fix-typo-in-documentation).
5. Make your changes in a new branch
6. Commit your changes with a clear and concise message, using conventional-changelog format.
7. Push the changes to your forked repository. 
8. Submit a pull request to the original repository.

> **Note:** Do not commit passwords or other secret/sensitive information, as they will be publicly available and can remain recorded in the GitHub history. If this happens, invalidate secrets immediately (e.g.: change password).


### How to report a bug

> You must never report security related issues, vulnerabilities or bugs including sensitive information to the issue tracker, or elsewhere in public. Instead sensitive bugs must be sent by email to <global.researchassessmentmonitoring@wfp.org>.

We use GitHub issues to track bugs and errors, request a new indicator or changes to an existing one or ask questions. If you run into an issue with the project:

- Open an [Issue](https://github.com/WFP-VAM/RAMResourcesScripts/issues/new/choose). 
- Choose whether you need to file a Bug report, request a new Indicator or changes to an existing one or just ask a question.
  - If it's a Bug, please provide as much context as possible and describe the *reproduction steps* that someone else can follow to recreate the issue on their own. This usually includes your code. For good bug reports you should isolate the problem and create a reduced test case.
-  If it's an Indicator, provide the name of the indicator, language/software that the indicator should be calculated in, the WFP unit that owns the indicator and whether it's part of the WFP Corporate Result Framework

Once it's filed the project team will prioritize the issue accordingly, also considering the reproducibility of the issue. 



## Styleguides
### Commit Messages

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


