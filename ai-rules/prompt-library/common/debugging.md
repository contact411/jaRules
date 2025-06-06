# Debugging Prompt Templates

## Comprehensive Bug Analysis

```
I'm encountering a bug and need help debugging it systematically:

**Bug Description**:
- **What's happening**: [Describe the actual behavior]
- **What should happen**: [Describe the expected behavior]
- **When it occurs**: [Specific conditions, user actions, or timing]
- **Frequency**: [Always, sometimes, random, specific scenarios]

**Environment Details**:
- **Platform**: [OS, browser, mobile device]
- **Version**: [App version, browser version, dependencies]
- **Environment**: [Development, staging, production]
- **Data conditions**: [Specific data that triggers the issue]

**Error Information**:
```
[PASTE ERROR MESSAGES, STACK TRACES, OR LOGS HERE]
```

**Code Context**:
```
[PASTE RELEVANT CODE SECTIONS HERE]
```

Please help me:
1. **Identify root cause** with logical reasoning
2. **Provide debugging steps** to isolate the issue
3. **Suggest fixes** with pros/cons of each approach
4. **Recommend prevention** strategies for similar issues

**Additional Context**: [Any other relevant information]
```

## Performance Issue Debugging

```
I'm experiencing performance problems and need help identifying the bottleneck:

**Performance Issue**:
- **Symptom**: [Slow loading, high CPU/memory, timeouts]
- **Timing**: [When did this start? Recent changes?]
- **Scale**: [Number of users, data volume, request patterns]
- **Impact**: [User experience, system stability, costs]

**Measurements**:
- **Response times**: [Specific timings, before/after comparisons]
- **Resource usage**: [CPU, memory, disk, network metrics]
- **Error rates**: [Increased errors, timeouts, failures]
- **User feedback**: [Complaints, usage patterns]

**System Context**:
- **Architecture**: [Infrastructure, services, dependencies]
- **Recent changes**: [Code deployments, config changes, data growth]
- **Monitoring data**: [Logs, metrics, profiling information]

**Code/Configuration**:
```
[PASTE RELEVANT CODE, QUERIES, OR CONFIG HERE]
```

Please help with:
1. **Performance profiling strategy** to identify bottlenecks
2. **Data analysis** of the provided metrics
3. **Optimization recommendations** with expected impact
4. **Monitoring improvements** to prevent future issues

**Environment**: [Production/staging details, infrastructure setup]
```

## Error Investigation

```
I need help investigating this error systematically:

**Error Details**:
- **Error message**: [Exact error text]
- **Error code**: [HTTP status, exception type, etc.]
- **Frequency**: [How often it occurs]
- **User impact**: [What users experience]

**Stack Trace/Logs**:
```
[PASTE COMPLETE STACK TRACE OR ERROR LOGS HERE]
```

**Reproduction Steps**:
1. [Step-by-step instructions to reproduce]
2. [Include any specific data or conditions needed]
3. [Note if it's reproducible or intermittent]

**System State**:
- **Recent changes**: [Code, config, infrastructure]
- **Dependencies**: [Third-party services, database, external APIs]
- **Load conditions**: [Traffic patterns, resource usage]
- **Data conditions**: [Specific records, edge cases]

**Investigation So Far**:
- **Attempted fixes**: [What you've already tried]
- **Hypothesis**: [Your current theory about the cause]
- **Additional symptoms**: [Related errors or issues]

Please provide:
1. **Root cause analysis** based on the evidence
2. **Investigation steps** to gather more information
3. **Fix recommendations** with implementation guidance
4. **Prevention strategies** to avoid recurrence

**Code Context**: [Relevant code sections, configuration files]
```

## Integration Issue Debugging

```
I'm having trouble with a system integration and need debugging help:

**Integration Details**:
- **Systems involved**: [Services, APIs, databases]
- **Integration type**: [REST API, GraphQL, message queue, database]
- **Data flow**: [How data moves between systems]
- **Authentication**: [API keys, OAuth, certificates]

**Problem Description**:
- **Expected behavior**: [What should happen]
- **Actual behavior**: [What's actually happening]
- **Error symptoms**: [Timeouts, 4xx/5xx errors, data corruption]
- **Impact scope**: [Which features/users affected]

**Technical Details**:
- **Request/Response examples**:
```
[PASTE API CALLS, RESPONSES, HEADERS]
```

- **Configuration**:
```
[PASTE RELEVANT CONFIG FILES, CONNECTION STRINGS]
```

**Debugging Information**:
- **Network traces**: [Request logs, response times]
- **Authentication logs**: [Token validation, permissions]
- **Data validation**: [Schema mismatches, format issues]
- **Infrastructure**: [Network connectivity, DNS, certificates]

**Environment Context**:
- **Environments affected**: [Dev, staging, prod]
- **Recent changes**: [API updates, infrastructure changes]
- **Dependencies**: [External service status, version changes]

Please help with:
1. **Integration diagnosis** to identify the failure point
2. **Testing strategy** to isolate the issue
3. **Fix recommendations** with implementation steps
4. **Monitoring setup** to prevent future issues

**Additional Context**: [Any other relevant technical details]
```

## Frontend/UI Debugging

```
I'm experiencing frontend issues and need help debugging:

**UI Problem**:
- **Visual issue**: [Layout broken, elements missing, styling problems]
- **Functional issue**: [Buttons not working, forms not submitting]
- **Performance issue**: [Slow rendering, memory leaks, freezing]
- **User experience**: [Confusing behavior, accessibility problems]

**Browser/Device Info**:
- **Browsers affected**: [Chrome, Firefox, Safari, mobile browsers]
- **Device types**: [Desktop, mobile, tablet, specific models]
- **Screen sizes**: [Responsive design issues]
- **Operating systems**: [Windows, macOS, iOS, Android]

**Console Errors**:
```
[PASTE BROWSER CONSOLE ERRORS, WARNINGS]
```

**Network Activity**:
- **Failed requests**: [API calls, resource loading]
- **Slow requests**: [Performance timeline]
- **CORS issues**: [Cross-origin problems]

**Code Context**:
```
[PASTE RELEVANT HTML, CSS, JAVASCRIPT]
```

**Reproduction**:
- **Steps to reproduce**: [Exact user actions]
- **Conditions**: [Specific data, user state, browser settings]
- **Consistency**: [Always happens, intermittent, specific scenarios]

Please provide:
1. **Issue diagnosis** with likely causes
2. **Debugging techniques** for frontend investigation
3. **Fix strategies** with code examples
4. **Testing approach** to verify the solution
5. **Browser compatibility** considerations

**Additional Info**: [User feedback, analytics data, etc.]
```

## Database Issue Debugging

```
I'm encountering database-related problems and need debugging assistance:

**Database Problem**:
- **Issue type**: [Performance, data corruption, connection issues, query errors]
- **Symptoms**: [Slow queries, deadlocks, timeout errors, incorrect results]
- **Impact**: [Features affected, user experience, data integrity]
- **Timing**: [When it started, patterns, frequency]

**Database Details**:
- **Database type**: [PostgreSQL, MySQL, MongoDB, etc.]
- **Version**: [Specific version numbers]
- **Size**: [Number of records, data volume, growth rate]
- **Infrastructure**: [Cloud provider, hardware specs, connection pooling]

**Query/Error Information**:
```
[PASTE PROBLEMATIC QUERIES, ERROR MESSAGES, EXECUTION PLANS]
```

**Performance Metrics**:
- **Query execution times**: [Before/after, specific timings]
- **Resource usage**: [CPU, memory, I/O, connections]
- **Lock information**: [Deadlocks, blocking queries]
- **Index usage**: [Missing indexes, unused indexes]

**Recent Changes**:
- **Schema changes**: [Table modifications, new indexes]
- **Query modifications**: [ORM changes, new features]
- **Data changes**: [Large imports, bulk operations]
- **Infrastructure**: [Hardware upgrades, configuration changes]

**Database Logs**:
```
[PASTE RELEVANT DATABASE LOGS, SLOW QUERY LOGS]
```

Please help with:
1. **Performance analysis** of queries and database operations
2. **Optimization recommendations** for schema and queries
3. **Diagnostic steps** to identify root causes
4. **Monitoring setup** for ongoing database health

**Schema Context**: [Relevant table structures, relationships, indexes]
```