# jaRules Cloudflare Worker

This Worker powers the legendary `https://jarule.dev` domain, providing instant access to jaRules' opinionated development environment setup.

## 🚀 Endpoints

### Main Installation
- `https://jarule.dev/setup` - The one command to rule them all
- `https://jarule.dev/setup/dotfiles` - Dotfiles only installation
- `https://jarule.dev/setup/rules` - AI rules only installation  
- `https://jarule.dev/setup/node` - Node.js setup only

### API & Info
- `https://jarule.dev/api/version` - Get version and repository info
- `https://jarule.dev/health` - Health check endpoint
- `https://jarule.dev/` - Beautiful landing page with instructions

## 📦 Deployment

### Prerequisites
1. Cloudflare account with `jarule.dev` domain
2. Wrangler CLI installed: `npm install -g wrangler`
3. Wrangler authenticated: `wrangler login`

### Deploy to Production
```bash
# Deploy the worker
cd cloudflare/
wrangler deploy --env production

# Verify deployment
curl -fsSL https://jarule.dev/health
```

### Development
```bash
# Start local development server
wrangler dev

# Test locally
curl -fsSL http://localhost:8787/setup
```

## ⚙️ Configuration

### DNS Setup in Cloudflare Dashboard
1. Go to your Cloudflare dashboard
2. Select the `jarule.dev` domain
3. Go to DNS → Records
4. Ensure you have the Worker route configured

### Worker Routes
The worker automatically handles all traffic to `jarule.dev/*` via the routes configuration in `wrangler.toml`.

## 🔧 Features

### Smart Caching
- Scripts cached for 5 minutes for performance
- GitHub API responses cached appropriately
- Static assets cached for 1 hour

### Error Handling
- Graceful fallbacks when GitHub is unavailable
- Bootstrap scripts when main installer isn't ready
- Helpful error messages with next steps

### CORS Support
- Full CORS headers for browser requests
- API endpoints accessible from web applications

### Analytics Ready
- Custom headers for tracking (`X-jaRules-Version`, `X-jaRules-Mode`)
- Structured logging for monitoring

## 🎯 Usage Examples

```bash
# Full installation
curl -fsSL https://jarule.dev/setup | sh

# Modular installations
curl -fsSL https://jarule.dev/setup/dotfiles | sh
curl -fsSL https://jarule.dev/setup/rules | sh
curl -fsSL https://jarule.dev/setup/node | sh

# Get version info
curl -s https://jarule.dev/api/version | jq .

# Health check
curl -s https://jarule.dev/health
```

## 🔒 Security

- No sensitive data stored in the worker
- All scripts fetched directly from GitHub
- HTTPS enforced for all endpoints
- No user data collection or tracking

## 📊 Monitoring

The worker includes built-in monitoring capabilities:
- Health check endpoint for uptime monitoring
- Version API for tracking deployments
- Error logging for debugging issues

## 🚀 Performance

- Global edge deployment via Cloudflare
- Sub-100ms response times worldwide
- Intelligent caching reduces GitHub API calls
- Optimized for shell script delivery