# Code Review Prompt Templates

## Comprehensive Code Review

```
Please conduct a thorough code review of the following code, focusing on:

**Code Quality**:
- Logic correctness and edge case handling
- Code clarity, readability, and maintainability
- Adherence to established patterns and conventions
- Appropriate use of language features and best practices

**Security Analysis**:
- Input validation and sanitization
- Authentication and authorization checks
- Potential vulnerabilities (injection, XSS, etc.)
- Secure handling of sensitive data

**Performance Considerations**:
- Algorithm efficiency and complexity
- Memory usage and potential leaks
- Database query optimization
- Caching opportunities

**Testing & Documentation**:
- Test coverage and quality
- Code documentation and comments
- API documentation updates needed
- Error handling and logging

**Architecture & Design**:
- Separation of concerns
- SOLID principles adherence
- Design pattern usage
- Integration with existing codebase

Please provide:
1. **Overall Assessment**: High-level feedback on code quality
2. **Specific Issues**: Line-by-line feedback with severity levels
3. **Improvement Suggestions**: Concrete recommendations
4. **Security Concerns**: Any security-related issues found
5. **Performance Notes**: Optimization opportunities

[PASTE CODE HERE]
```

## Quick Security Review

```
Please review this code specifically for security vulnerabilities:

**Security Checklist**:
- [ ] Input validation (SQL injection, XSS, command injection)
- [ ] Authentication and authorization
- [ ] Sensitive data handling (encryption, secure storage)
- [ ] Error handling (information disclosure)
- [ ] Dependencies (known vulnerabilities)
- [ ] Configuration security (hardcoded secrets, insecure defaults)

Focus on:
1. **Critical vulnerabilities** that could lead to data breaches
2. **Medium-risk issues** that should be addressed before production
3. **Best practice improvements** for defense in depth

[PASTE CODE HERE]
```

## Performance Review

```
Analyze this code for performance issues and optimization opportunities:

**Performance Analysis**:
- Algorithm complexity (Big O notation)
- Memory usage patterns
- I/O operations efficiency
- Caching strategies
- Database query optimization

**Specific Areas**:
- Bottlenecks and hot paths
- Unnecessary computations or allocations
- Blocking operations that could be async
- Data structure choices
- Loop optimizations

Please provide:
1. **Performance bottlenecks** with impact assessment
2. **Optimization recommendations** with expected improvements
3. **Benchmarking suggestions** for measuring improvements
4. **Trade-offs** between performance and maintainability

[PASTE CODE HERE]
```

## Architecture Review

```
Review this code from an architectural perspective:

**Architecture Evaluation**:
- Separation of concerns and modularity
- SOLID principles application
- Design pattern usage and appropriateness
- Coupling and cohesion analysis
- Scalability considerations

**Integration Assessment**:
- How well does this fit with existing codebase?
- Are there breaking changes or compatibility issues?
- Does it follow established conventions?
- Are interfaces well-defined and stable?

**Maintainability Factors**:
- Code complexity and readability
- Testability and debugging ease
- Documentation quality
- Extensibility for future requirements

Provide feedback on:
1. **Architectural strengths** and good practices
2. **Areas for improvement** with specific suggestions
3. **Refactoring opportunities** to improve design
4. **Long-term maintainability** considerations

[PASTE CODE HERE]
```

## Pull Request Review

```
Please review this pull request comprehensively:

**PR Context**:
- Feature/bugfix description: [DESCRIPTION]
- Related issues: [ISSUE_LINKS]
- Breaking changes: [YES/NO - DETAILS]

**Review Checklist**:
- [ ] Functionality works as described
- [ ] Code follows project conventions
- [ ] Tests are included and comprehensive
- [ ] Documentation is updated
- [ ] No security vulnerabilities introduced
- [ ] Performance impact considered
- [ ] Backward compatibility maintained

**Specific Review Areas**:
1. **Code Quality**: Style, readability, maintainability
2. **Functionality**: Logic correctness, edge cases
3. **Testing**: Coverage, quality, edge case testing
4. **Documentation**: Comments, README updates, API docs
5. **Integration**: Impact on existing features

Please provide:
- **Approval status**: Approve/Request Changes/Comment
- **Priority issues**: Critical items that must be fixed
- **Suggestions**: Nice-to-have improvements
- **Questions**: Areas needing clarification

[PASTE CODE/DIFF HERE]
```

## Legacy Code Review

```
Review this legacy code for modernization opportunities:

**Legacy Assessment**:
- Current state analysis and technical debt
- Security vulnerabilities in older patterns
- Performance issues with outdated approaches
- Compatibility with modern tooling

**Modernization Strategy**:
- Language/framework version upgrades
- Pattern updates and refactoring opportunities
- Dependency updates and security patches
- Testing strategy for legacy code

**Risk Analysis**:
- What could break during modernization?
- Which changes provide the most value?
- How to maintain backward compatibility?
- Testing strategy for regression prevention

Provide:
1. **Technical debt assessment** with priority ranking
2. **Modernization roadmap** with phases
3. **Risk mitigation strategies** for safe updates
4. **Quick wins** that provide immediate value

[PASTE LEGACY CODE HERE]
```