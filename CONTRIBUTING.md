# Contributing to jaRules

Thank you for considering contributing to jaRules! This document provides guidelines for contributing to this project.

## Code of Conduct

By participating in this project, you agree to maintain a respectful and inclusive environment for all contributors.

## How to Contribute

### Reporting Issues

1. **Search existing issues** before creating a new one
2. **Use clear, descriptive titles** for bug reports and feature requests
3. **Provide detailed information** including:
   - Operating system and version
   - Shell type and version
   - Steps to reproduce the issue
   - Expected vs. actual behavior
   - Relevant log output or screenshots

### Submitting Changes

1. **Fork the repository** and create a feature branch
2. **Write clear, concise commit messages** following conventional commits format:
   ```
   type(scope): description
   
   - feat: new feature
   - fix: bug fix
   - docs: documentation changes
   - style: formatting changes
   - refactor: code refactoring
   - test: adding or modifying tests
   - chore: maintenance tasks
   ```

3. **Test your changes** across different platforms when possible
4. **Update documentation** if your changes affect user-facing functionality
5. **Submit a pull request** with a clear description of your changes

### Development Guidelines

#### Code Style
- Use consistent shell scripting practices
- Add comments for complex logic
- Follow existing patterns and conventions
- Ensure scripts are POSIX-compliant where possible

#### Testing
- Test on multiple platforms (macOS, Linux, Windows)
- Verify compatibility with different shells (bash, zsh, fish)
- Test both fresh installations and updates

#### Documentation
- Update README.md for user-facing changes
- Update CHANGELOG.md following semantic versioning
- Add inline comments for complex configurations
- Ensure all features have usage examples

## Development Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/YOUR_USERNAME/jaRules.git
   cd jaRules
   ```

2. Test the installation script:
   ```bash
   ./install.sh --help
   ```

3. Make your changes and test:
   ```bash
   # Test specific components
   ./scripts/setup-shell-script.sh
   ./scripts/setup-git-script.sh
   ```

## Project Structure

```
jaRules/
├── install.sh              # Main installation script
├── scripts/                # Individual setup scripts
│   ├── setup-shell-script.sh
│   ├── setup-git-script.sh
│   └── ...
├── config/                 # Configuration templates
├── ai-rules/               # AI assistant configurations
├── docs/                   # Additional documentation
└── website/                # Project website source
```

## Questions?

- Open a [Discussion](https://github.com/YOUR_USERNAME/jaRules/discussions) for general questions
- Create an [Issue](https://github.com/YOUR_USERNAME/jaRules/issues) for bugs or feature requests
- Check existing documentation in the `docs/` directory

## License

By contributing to jaRules, you agree that your contributions will be licensed under the same license as the project.
