# Security Policy

## Reporting Security Issues

We take security seriously at Intent Kit. If you discover a security vulnerability, please report it responsibly.

**Do not** open public issues for security vulnerabilities. Instead, please report them using one of the following methods:

### Report via Email

Send security reports to: [security@intended.dev]

### Report via GitHub

If you have a GitHub account, you can also report security issues through GitHub's private vulnerability reporting feature:

1. Go to the [Intent Kit repository](ç)
2. Click on the "Security" tab
3. Click "Report a vulnerability"
4. Fill out the form with details about the vulnerability

## Security Vulnerability Response Process

When you report a security vulnerability:

1. **Acknowledgment**: We will acknowledge receipt of your report within 24 hours
2. **Assessment**: Our security team will assess the vulnerability and determine its severity
3. **Fix Development**: If confirmed, we will develop a fix for the vulnerability
4. **Testing**: The fix will be thoroughly tested to ensure it resolves the issue without introducing regressions
5. **Release**: A security update will be released as soon as possible
6. **Disclosure**: We will coordinate disclosure timing with you if requested

## Supported Versions

Security updates are provided for the current major version and the immediately previous major version. For example:

- ✅ **1.x**: Receives security updates
- ✅ **0.x**: Receives security updates (if 1.x is the current version)
- ❌ **0.(x-2)**: No longer receives security updates

Check the [CHANGELOG.md](./CHANGELOG.md) for the latest version information.

## Security Best Practices

### For Users

- **Keep dependencies updated**: Regularly update Intent Kit and all dependencies
- **Use supported versions**: Only use versions that receive security updates
- **Validate inputs**: Always validate and sanitize user inputs in your applications
- **Follow principle of least privilege**: Grant minimal necessary permissions
- **Monitor for vulnerabilities**: Use tools like `pip-audit` or `npm audit` to check for known vulnerabilities

### For Contributors

- **Follow secure coding practices**: Use parameterized queries, validate inputs, avoid dangerous functions
- **Write security tests**: Include tests for common vulnerability patterns
- **Review security implications**: Consider security impact when reviewing pull requests
- **Report vulnerabilities**: If you find a vulnerability, report it following the process above

## Vulnerability Disclosure Policy

### Timeline

- **Zero-day vulnerabilities**: Fixed within 30 days of report
- **High severity**: Fixed within 14 days of report
- **Medium severity**: Fixed within 30 days of report
- **Low severity**: Fixed in next regular release

### Public Disclosure

We believe in responsible disclosure. We will:

- Coordinate with reporters on disclosure timing
- Provide advance notice of security releases when possible
- Credit reporters in release notes (with permission)
- Publish detailed vulnerability information after fixes are available

## Security Features

Intent Kit includes several security-focused features:

### Input Validation

- All CLI inputs are validated and sanitized
- Template injection prevention in generated files
- Safe path handling to prevent directory traversal

### Dependency Management

- Minimal dependencies to reduce attack surface
- Regular dependency updates and security audits
- Use of trusted package repositories only

### Agent Integration Security

- Secure handling of API keys and tokens
- No storage of sensitive credentials in generated files
- Validation of agent responses and outputs

## Security Audit

Intent Kit undergoes regular security audits:

- **Code review**: All changes are reviewed for security implications
- **Dependency scanning**: Automated scanning for vulnerable dependencies
- **Static analysis**: Use of security-focused static analysis tools
- **Penetration testing**: Regular penetration testing of the CLI and generated code

## Contact

For security-related questions or concerns:

- **Security reports**: [security@intended.dev]
- **General security questions**: [security@intended.dev]
- **GitHub Issues**: Use the "Security" tab for private vulnerability reports

---

Thank you for helping keep Intent Kit and the intent-driven development community secure!
