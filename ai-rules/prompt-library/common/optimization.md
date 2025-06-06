# Code Optimization Prompt Templates

## Performance Optimization Analysis

```
Please analyze this code for performance optimization opportunities:

**Optimization Goals**:
- [ ] Reduce execution time
- [ ] Lower memory usage  
- [ ] Improve scalability
- [ ] Reduce resource costs
- [ ] Better user experience

**Current Performance Context**:
- **Execution time**: [Current timing measurements]
- **Memory usage**: [Current memory consumption]
- **Scale**: [Current load, expected growth]
- **Bottlenecks**: [Known performance issues]

**Code to Optimize**:
```
[PASTE CODE HERE]
```

**Usage Patterns**:
- **Frequency**: [How often this code runs]
- **Data volume**: [Input size, iteration counts]
- **Concurrency**: [Parallel execution, thread safety]
- **Caching**: [Current caching strategy]

Please provide:

1. **Performance Analysis**:
   - Algorithm complexity (Big O notation)
   - Memory allocation patterns
   - I/O operations efficiency
   - Computational bottlenecks

2. **Optimization Recommendations**:
   - Specific code improvements with examples
   - Data structure optimizations
   - Algorithm alternatives
   - Caching strategies

3. **Implementation Priority**:
   - High-impact, low-effort optimizations
   - Medium-impact improvements
   - Long-term architectural changes

4. **Trade-off Analysis**:
   - Performance vs maintainability
   - Memory vs speed
   - Complexity vs optimization gains

5. **Measurement Strategy**:
   - Benchmarking approach
   - Metrics to track
   - Performance regression prevention

**Constraints**: [Technology limitations, backward compatibility requirements]
```

## Database Query Optimization

```
Help me optimize these database queries for better performance:

**Database Context**:
- **Database type**: [PostgreSQL, MySQL, MongoDB, etc.]
- **Table sizes**: [Number of records in relevant tables]
- **Current indexes**: [Existing index configuration]
- **Query frequency**: [How often these queries run]

**Performance Issues**:
- **Slow execution times**: [Current timing measurements]
- **High resource usage**: [CPU, memory, I/O impact]
- **Blocking issues**: [Deadlocks, long-running transactions]
- **Scalability concerns**: [Performance degradation patterns]

**Queries to Optimize**:
```sql
[PASTE SQL QUERIES HERE]
```

**Execution Plans**:
```
[PASTE QUERY EXECUTION PLANS IF AVAILABLE]
```

**Schema Information**:
```sql
[PASTE RELEVANT TABLE SCHEMAS, INDEXES, CONSTRAINTS]
```

Please provide:

1. **Query Analysis**:
   - Execution plan interpretation
   - Performance bottleneck identification
   - Index usage analysis
   - Join operation efficiency

2. **Optimization Strategies**:
   - Query rewriting suggestions
   - Index recommendations (create, modify, remove)
   - Schema improvements
   - Partitioning strategies

3. **Implementation Steps**:
   - Priority order for optimizations
   - Safe deployment strategies
   - Performance testing approach
   - Rollback procedures

4. **Monitoring Setup**:
   - Key metrics to track
   - Query performance alerts
   - Long-term trend analysis

**Additional Context**: [Data access patterns, application constraints]
```

## Frontend Performance Optimization

```
Analyze this frontend code for performance improvements:

**Performance Goals**:
- [ ] Faster page load times
- [ ] Improved runtime performance
- [ ] Better mobile experience
- [ ] Reduced bundle size
- [ ] Enhanced user experience

**Current Metrics**:
- **Page load time**: [Current measurements]
- **Bundle size**: [JavaScript, CSS, asset sizes]
- **Core Web Vitals**: [LCP, FID, CLS scores]
- **User feedback**: [Performance-related complaints]

**Code to Optimize**:
```javascript
[PASTE FRONTEND CODE HERE]
```

**Application Context**:
- **Framework**: [React, Vue, Angular, vanilla JS]
- **Build tools**: [Webpack, Vite, Parcel, etc.]
- **Deployment**: [CDN, caching strategy, hosting]
- **User base**: [Device types, network conditions]

**Performance Audit Areas**:

1. **Loading Performance**:
   - Bundle analysis and splitting
   - Resource loading strategies
   - Critical path optimization
   - Asset compression and caching

2. **Runtime Performance**:
   - Rendering optimization
   - Memory leak prevention
   - Event handling efficiency
   - Animation performance

3. **Network Optimization**:
   - API call optimization
   - Resource prefetching
   - Caching strategies
   - Image optimization

Please provide:

1. **Performance Assessment**:
   - Current bottlenecks and impact
   - Measurement baseline
   - User experience implications

2. **Optimization Recommendations**:
   - Code-level improvements with examples
   - Build configuration changes
   - Architecture modifications
   - Third-party optimization

3. **Implementation Plan**:
   - Quick wins for immediate impact
   - Medium-term improvements
   - Long-term architecture changes

4. **Monitoring Strategy**:
   - Performance metrics to track
   - Automated testing setup
   - User experience monitoring

**Constraints**: [Browser support, framework limitations, team expertise]
```

## Algorithm Optimization

```
Help me optimize this algorithm for better performance:

**Algorithm Context**:
- **Purpose**: [What the algorithm accomplishes]
- **Input characteristics**: [Data size, format, constraints]
- **Output requirements**: [Format, accuracy, completeness]
- **Performance requirements**: [Speed, memory, scalability]

**Current Implementation**:
```
[PASTE ALGORITHM CODE HERE]
```

**Performance Measurements**:
- **Time complexity**: [Current Big O analysis]
- **Space complexity**: [Memory usage analysis]
- **Benchmark results**: [Timing data, profiling results]
- **Scalability testing**: [Performance at different input sizes]

**Optimization Objectives**:
- [ ] Reduce time complexity
- [ ] Minimize memory usage
- [ ] Improve cache efficiency
- [ ] Enable parallelization
- [ ] Handle larger datasets

**Constraints and Requirements**:
- **Accuracy requirements**: [Precision, error tolerance]
- **Memory limitations**: [Available RAM, cache size]
- **Real-time constraints**: [Latency requirements]
- **Parallelization options**: [Multi-threading, GPU acceleration]

Please provide:

1. **Algorithm Analysis**:
   - Current complexity assessment
   - Bottleneck identification
   - Data structure efficiency
   - Memory access patterns

2. **Optimization Strategies**:
   - Alternative algorithms with better complexity
   - Data structure improvements
   - Cache-friendly optimizations
   - Parallelization opportunities

3. **Implementation Options**:
   - Incremental improvements to existing code
   - Complete algorithm replacement
   - Hybrid approaches
   - Library/framework alternatives

4. **Trade-off Analysis**:
   - Performance vs accuracy
   - Memory vs speed
   - Complexity vs maintainability
   - Development time vs optimization gains

5. **Validation Strategy**:
   - Correctness testing
   - Performance benchmarking
   - Regression testing
   - Edge case validation

**Domain Context**: [Specific field requirements, industry standards]
```

## System Architecture Optimization

```
Please analyze this system architecture for performance and scalability optimization:

**System Overview**:
- **Architecture type**: [Monolith, microservices, serverless, hybrid]
- **Technology stack**: [Languages, frameworks, databases, infrastructure]
- **Scale**: [Current users, data volume, transaction rates]
- **Growth projections**: [Expected scaling requirements]

**Current Architecture**:
```
[PASTE ARCHITECTURE DIAGRAMS, DESCRIPTIONS, OR CODE STRUCTURE]
```

**Performance Challenges**:
- **Bottlenecks**: [Specific components or operations]
- **Resource utilization**: [CPU, memory, network, storage]
- **User experience issues**: [Latency, availability, reliability]
- **Operational challenges**: [Deployment, monitoring, debugging]

**Optimization Goals**:
- [ ] Improve response times
- [ ] Increase throughput
- [ ] Reduce infrastructure costs
- [ ] Enhance reliability
- [ ] Simplify operations

**Current Metrics**:
- **Performance**: [Response times, throughput measurements]
- **Reliability**: [Uptime, error rates, recovery times]
- **Scalability**: [Load testing results, breaking points]
- **Costs**: [Infrastructure, operational, development costs]

Please analyze:

1. **Architecture Assessment**:
   - Component interaction efficiency
   - Data flow optimization opportunities
   - Scalability bottlenecks
   - Single points of failure

2. **Optimization Strategies**:
   - Caching strategies (application, database, CDN)
   - Load balancing and distribution
   - Database optimization (sharding, replication, indexing)
   - Service decomposition or consolidation

3. **Infrastructure Improvements**:
   - Horizontal vs vertical scaling strategies
   - Cloud service optimization
   - CDN and edge computing opportunities
   - Container and orchestration optimization

4. **Implementation Roadmap**:
   - Quick wins with immediate impact
   - Medium-term architectural changes
   - Long-term transformation goals
   - Risk mitigation strategies

5. **Monitoring and Observability**:
   - Key metrics and alerting
   - Performance tracking
   - Capacity planning
   - Cost optimization monitoring

**Constraints**: [Budget, team expertise, legacy system dependencies, compliance requirements]
```