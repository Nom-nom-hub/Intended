# Intent Kit Command Template Standard

This document defines the standard structure and format for all Intent Kit command templates.

## Required Structure

### Front Matter (YAML)

```yaml
---
description: Brief description with enhanced features mentioned
scripts:
  sh: scripts/bash/script-name.sh --json [options]
  ps: scripts/powershell/script-name.ps1 -Json [options]
agent_scripts:  # Optional, for agent context updates
  sh: scripts/bash/update-agent-context.sh __AGENT__
  ps: scripts/powershell/update-agent-context.ps1 -AgentType __AGENT__
---
```

### Content Sections

1. **User Input Section**

    ```markdown
   # User Input

   `$ARGUMENTS`

   You **MUST** consider the user input before proceeding (if not empty).
   ```

2. **Enhanced Features Integration** (Required)

    ```markdown
   ## Enhanced Features Integration

   [Describe how this command integrates with enhanced features]
   - Feature 1: Description
   - Feature 2: Description
   ```

3. **Goal Section** (Required)

    ```markdown
   ## Goal

   [Clear statement of what this command achieves]
   ```

4. **Operating Constraints** (Required)

    ```markdown
   ## Operating Constraints

   [List prerequisites, limitations, and critical requirements]
   ```

5. **Execution Steps** (Required)

    ```markdown
   ## Execution Steps

   ### 1. Step Name
   [Detailed instructions]

   ### 2. Step Name
   [Detailed instructions]
   ```

6. **Error Handling** (Required)

    ```markdown
   ## Error Handling

   [How to handle common errors and edge cases]
   ```

7. **Progress Tracking** (Required)

    ```markdown
   ## Progress Tracking

   [How progress is reported and tracked]
   ```

## Enhanced Features Integration Guidelines

All templates must integrate with these enhanced features where applicable:

- **Version Control**: Reference git integration for tracking
- **Artifact Discovery**: Mention artifact scanning capabilities
- **Quality Validation**: Include quality checks and metrics
- **Dependency Analysis**: Reference dependency graph features
- **Caching**: Mention performance optimizations
- **Constitution Compliance**: Reference constitution validation

## Template Quality Standards

- **Consistency**: All templates follow the same structure
- **Completeness**: No missing required sections
- **Clarity**: Instructions are unambiguous and actionable
- **Integration**: Enhanced features are properly referenced
- **Error Handling**: Comprehensive error scenarios covered
- **Progress Tracking**: Clear progress indicators defined

## Validation Checklist

Before committing a template update, verify:

- [ ] Front matter is valid YAML
- [ ] All required sections are present
- [ ] Enhanced features are integrated appropriately
- [ ] Script references are correct and exist
- [ ] Error handling covers common scenarios
- [ ] Progress tracking is well-defined
- [ ] Markdown formatting is consistent
- [ ] No broken links or references
