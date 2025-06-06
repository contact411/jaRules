# Foundational System Requirements Template

## Project Context
**Project Name**: [PROJECT_NAME]  
**Type**: [web-app | api-server | mobile-app | desktop-app | library | cli-tool]  
**Target Audience**: [internal-team | external-users | developers | end-users]  
**Scale**: [prototype | MVP | production | enterprise]

## Technical Architecture

### Core Technology Stack
- **Primary Language**: [JavaScript/TypeScript | Python | Go | Rust | Java | etc.]
- **Framework**: [React | Vue | Express | FastAPI | Spring | etc.]
- **Database**: [PostgreSQL | MongoDB | Redis | SQLite | etc.]
- **Runtime Environment**: [Node.js | Python 3.x | JVM | Docker | etc.]

### Infrastructure Requirements
- **Hosting**: [AWS | GCP | Azure | Vercel | Heroku | self-hosted]
- **Containerization**: [Docker | Kubernetes | Docker Compose | none]
- **CI/CD**: [GitHub Actions | GitLab CI | Jenkins | CircleCI]
- **Monitoring**: [Logging | Error tracking | Performance monitoring | Analytics]

## Non-Functional Requirements

### Performance Standards
- **Response Time**: API endpoints < 200ms, Page loads < 2s
- **Throughput**: [Concurrent users | Requests per second | Data volume]
- **Scalability**: [Horizontal | Vertical | Auto-scaling requirements]
- **Availability**: [99.9% uptime | Planned downtime windows | SLA requirements]

### Security Requirements
- **Authentication**: [OAuth 2.0 | JWT | Session-based | API keys]
- **Authorization**: [RBAC | ABAC | Simple permissions | Admin/User roles]
- **Data Protection**: [Encryption at rest | TLS in transit | PII handling]
- **Compliance**: [GDPR | HIPAA | SOC 2 | Industry-specific requirements]

### Operational Requirements
- **Backup Strategy**: [Automated daily | Real-time replication | Point-in-time recovery]
- **Disaster Recovery**: [RTO/RPO targets | Multi-region | Backup procedures]
- **Maintenance**: [Update procedures | Rollback strategy | Zero-downtime deployments]
- **Support**: [24/7 monitoring | On-call procedures | Issue escalation]

## Development Standards

### Code Quality
- **Code Style**: [ESLint + Prettier | Black + isort | Standard formatting tools]
- **Testing**: [Unit tests 80%+ coverage | Integration tests | E2E tests]
- **Documentation**: [API docs | Code comments | Architecture docs | User guides]
- **Review Process**: [Pull request reviews | Automated testing | Security scanning]

### Development Workflow
- **Version Control**: Git with [GitHub | GitLab | Bitbucket]
- **Branching Strategy**: [Git Flow | GitHub Flow | Feature branches]
- **Environment Management**: [Development | Staging | Production | Local setup]
- **Dependency Management**: [Lock files | Security scanning | Update procedures]

## Integration Requirements

### External Services
- **APIs**: [REST | GraphQL | gRPC | WebSockets]
- **Third-Party Services**: [Payment processing | Email | SMS | Analytics]
- **Data Sources**: [External databases | File systems | Message queues]
- **Authentication Providers**: [Google | GitHub | Auth0 | LDAP]

### Data Requirements
- **Data Models**: [Core entities | Relationships | Constraints]
- **Data Migration**: [Import procedures | Schema changes | Data validation]
- **Data Retention**: [Storage policies | Archival | GDPR compliance]
- **Data Privacy**: [Anonymization | Encryption | Access controls]

## Success Criteria

### Technical Metrics
- **Performance**: [Load time goals | Error rate thresholds | Availability targets]
- **Security**: [Vulnerability scan results | Penetration test findings]
- **Quality**: [Code coverage | Bug rates | Customer satisfaction]
- **Maintainability**: [Technical debt metrics | Documentation completeness]

### Business Metrics
- **User Adoption**: [Active users | Feature usage | Retention rates]
- **Operational Efficiency**: [Deployment frequency | Mean time to recovery]
- **Cost Management**: [Infrastructure costs | Development velocity]
- **Compliance**: [Audit results | Certification status]

## Risk Assessment

### Technical Risks
- **Scalability**: [Performance bottlenecks | Resource constraints]
- **Security**: [Data breaches | Access control failures]
- **Reliability**: [System failures | Data loss | Service disruptions]
- **Complexity**: [Technical debt | Integration challenges]

### Mitigation Strategies
- **Monitoring**: [Real-time alerts | Automated testing | Health checks]
- **Backup Plans**: [Rollback procedures | Alternative solutions | Vendor diversity]
- **Documentation**: [Runbooks | Incident response | Knowledge transfer]
- **Training**: [Team skill development | Best practice sharing]

## Implementation Timeline

### Phase 1: Foundation (Weeks 1-2)
- [ ] Development environment setup
- [ ] Core architecture implementation
- [ ] Basic CI/CD pipeline
- [ ] Initial security configuration

### Phase 2: Core Features (Weeks 3-6)
- [ ] Primary functionality development
- [ ] Database schema implementation
- [ ] API development and testing
- [ ] User interface creation

### Phase 3: Integration (Weeks 7-8)
- [ ] Third-party service integration
- [ ] Performance optimization
- [ ] Security testing and hardening
- [ ] Documentation completion

### Phase 4: Launch Preparation (Weeks 9-10)
- [ ] Production environment setup
- [ ] Load testing and optimization
- [ ] Monitoring and alerting configuration
- [ ] Team training and handover

---

*Use this template as a foundation for technical discussions and project planning. Customize sections based on your specific project needs and organizational requirements.*