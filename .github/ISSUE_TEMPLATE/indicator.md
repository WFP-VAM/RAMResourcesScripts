----
name: "Indicator"
description: Request the modification or addition of an indicator
title: "[Indicator]: "
labels: ["new", "enhancements"]
----
assignees:
  - ValerioGiuffrida

body:
  - type: markdown
    attributes:
      value: |
        Thanks for taking the time to fill out this bug report!

  - type: input
    id: contact
    attributes:
      label: Contact Details
      description: How can we get in touch with you if we need more info?
      placeholder: ex. email@example.com
    validations:
      required: true

  - type: checkboxes
    id: isCrf
    attributes:
      label: Corporate Result Framework
      description: Is the indicator included in the CRF or piloted in the indicator compendium?
      options: ["CRF", "Pilot", "No"]
        - label: Yes
          required: true

  - type: input
    id: owner-unit
    attributes:
      label: Unit owning the indicator
      description: Which unit has designed the indicator (in particular if CRF indicator)?
      placeholder: ex. RAM-E
    validations:
      required: true

  - type: textarea
    id: batch-creation
    attributes:
      label: No modifications
      description: Do not modify this area.
      placeholder: Tell us what you see!
      value: "- [ ] Create R script
        - [ ]  Create SPSS script
        - [ ]  Create Stata script"
    validations:
      required: true

  - type: dropdown
    id: Software-version
    attributes:
      label: Software version
      multiple: true
      description: What software would you like to use for the calculation of this index?
      options:
        - R
        - SPSS
        - Stata
        - Python
    validations:
      required: true

  - type: textarea
    id: logs
    attributes:
      label: Relevant log output
      description: Please copy and paste any relevant log output. This will be automatically formatted into code, so no need for backticks.
      render: shell

  - type: checkboxes
    id: terms
    attributes:
      label: Code of Conduct
      description: By submitting this issue, you agree to follow our [Code of Conduct](https://example.com)
      options:
        - label: I agree to follow this project's Code of Conduct
          required: true
