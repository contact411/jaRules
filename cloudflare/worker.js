/**
 * jaRules Cloudflare Worker
 * The legendary gateway to the ultimate development environment
 */

export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);
    const path = url.pathname;
    
    // CORS headers for browser requests
    const corsHeaders = {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type',
    };
    
    // Handle CORS preflight
    if (request.method === 'OPTIONS') {
      return new Response(null, { headers: corsHeaders });
    }
    
    try {
      // Main setup script endpoint
      if (path === '/setup') {
        return await handleSetupScript(request, corsHeaders);
      }
      
      // Modular installation endpoints
      if (path === '/setup/dotfiles') {
        return await handleModularScript(request, corsHeaders, 'dotfiles-only');
      }
      
      if (path === '/setup/rules') {
        return await handleModularScript(request, corsHeaders, 'rules-only');
      }
      
      if (path === '/setup/node') {
        return await handleNodeScript(request, corsHeaders);
      }
      
      // Root domain - redirect to GitHub with style
      if (path === '/' || path === '') {
        return await handleRootRedirect();
      }
      
      // API endpoint for getting latest version info
      if (path === '/api/version') {
        return await handleVersionAPI(corsHeaders);
      }
      
      // Health check endpoint
      if (path === '/health') {
        return new Response(JSON.stringify({ 
          status: 'legendary',
          message: 'jaRules is ready to transform your development environment',
          timestamp: new Date().toISOString()
        }), {
          headers: { 
            'Content-Type': 'application/json',
            ...corsHeaders
          }
        });
      }
      
      // 404 with style
      return await handle404();
      
    } catch (error) {
      console.error('Worker error:', error);
      return new Response(JSON.stringify({
        error: 'Internal server error',
        message: 'Even legends sometimes stumble. Please try again.',
        timestamp: new Date().toISOString()
      }), {
        status: 500,
        headers: { 
          'Content-Type': 'application/json',
          ...corsHeaders
        }
      });
    }
  }
};

/**
 * Handle the main setup script endpoint
 */
async function handleSetupScript(request, corsHeaders) {
  const installScript = await fetchGitHubFile('scripts/install.sh');
  
  if (!installScript) {
    return new Response(`#!/bin/bash
# jaRules Setup Script - Bootstrap Version
echo "🎯 Welcome to jaRules - Master of All Things Smooth"
echo "⚠️  Main installer not ready yet. Cloning repository..."

git clone https://github.com/contact411/jaRules.git jarule-setup
cd jarule-setup
chmod +x scripts/setup-node.sh
./scripts/setup-node.sh

echo "✅ Node.js setup completed!"
echo "💡 Full jaRules installation coming soon..."
`, {
      headers: {
        'Content-Type': 'text/plain; charset=utf-8',
        'Cache-Control': 'public, max-age=300',
        'X-jaRules-Version': 'bootstrap',
        ...corsHeaders
      }
    });
  }
  
  return new Response(installScript, {
    headers: {
      'Content-Type': 'text/plain; charset=utf-8',
      'Cache-Control': 'public, max-age=300',
      'X-jaRules-Version': 'latest',
      'X-Content-Source': 'github',
      ...corsHeaders
    }
  });
}

/**
 * Handle modular installation scripts
 */
async function handleModularScript(request, corsHeaders, mode) {
  const installScript = await fetchGitHubFile('scripts/install.sh');
  
  const modularScript = `#!/bin/bash
# jaRules Modular Setup - ${mode}
export JARULES_MODE="${mode}"
${installScript || generateBootstrapScript(mode)}
`;

  return new Response(modularScript, {
    headers: {
      'Content-Type': 'text/plain; charset=utf-8',
      'Cache-Control': 'public, max-age=300',
      'X-jaRules-Mode': mode,
      ...corsHeaders
    }
  });
}

/**
 * Handle Node.js specific setup
 */
async function handleNodeScript(request, corsHeaders) {
  const nodeScript = await fetchGitHubFile('scripts/setup-node.sh');
  
  if (!nodeScript) {
    return new Response(`#!/bin/bash
echo "⚠️  Node.js setup script not found. Using fallback..."
curl -fsSL https://raw.githubusercontent.com/contact411/jaRules/main/scripts/setup-node.sh | bash
`, {
      headers: {
        'Content-Type': 'text/plain; charset=utf-8',
        'Cache-Control': 'public, max-age=300',
        ...corsHeaders
      }
    });
  }
  
  return new Response(nodeScript, {
    headers: {
      'Content-Type': 'text/plain; charset=utf-8',
      'Cache-Control': 'public, max-age=300',
      'X-jaRules-Component': 'node',
      ...corsHeaders
    }
  });
}

/**
 * Handle root domain redirect with style
 */
async function handleRootRedirect() {
  const html = `<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>jaRules - Master of All Things Smooth</title>
    <style>
        body {
            font-family: 'SF Mono', 'Monaco', 'Cascadia Code', monospace;
            background: linear-gradient(135deg, #1e1e2e, #313244);
            color: #cdd6f4;
            margin: 0;
            padding: 2rem;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .container {
            text-align: center;
            max-width: 800px;
        }
        h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
            background: linear-gradient(45deg, #f5c2e7, #cba6f7);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .tagline {
            font-size: 1.2rem;
            color: #a6adc8;
            margin-bottom: 2rem;
        }
        .command {
            background: #181825;
            border: 1px solid #45475a;
            border-radius: 8px;
            padding: 1.5rem;
            margin: 2rem 0;
            font-family: inherit;
            font-size: 1.1rem;
        }
        .command code {
            color: #a6e3a1;
        }
        .links {
            margin-top: 2rem;
        }
        .links a {
            color: #89b4fa;
            text-decoration: none;
            margin: 0 1rem;
            transition: color 0.3s;
        }
        .links a:hover {
            color: #b4befe;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>⚡ jaRules</h1>
        <p class="tagline">Master of All Things Smooth</p>
        <p>The most opinionated dotfiles in the Joloverse</p>
        
        <div class="command">
            <strong>The One Command to Rule Them All:</strong><br>
            <code>curl -fsSL https://jarule.dev/setup | sh</code>
        </div>
        
        <div class="command">
            <strong>Modular Installation:</strong><br>
            <code>curl -fsSL https://jarule.dev/setup/dotfiles | sh</code><br>
            <code>curl -fsSL https://jarule.dev/setup/rules | sh</code><br>
            <code>curl -fsSL https://jarule.dev/setup/node | sh</code>
        </div>
        
        <div class="links">
            <a href="https://github.com/contact411/jaRules">📚 Documentation</a>
            <a href="https://github.com/contact411/jaRules/blob/main/docs/DOTFILES.md">🛠️ Configuration Guide</a>
            <a href="/api/version">📊 Version Info</a>
        </div>
    </div>
</body>
</html>`;
  
  return new Response(html, {
    headers: {
      'Content-Type': 'text/html; charset=utf-8',
      'Cache-Control': 'public, max-age=3600',
    }
  });
}

/**
 * Handle version API endpoint
 */
async function handleVersionAPI(corsHeaders) {
  try {
    const response = await fetch('https://api.github.com/repos/contact411/jaRules/commits/main');
    const commit = await response.json();
    
    return new Response(JSON.stringify({
      version: 'latest',
      commit: commit.sha?.substring(0, 7) || 'unknown',
      lastUpdated: commit.commit?.committer?.date || new Date().toISOString(),
      repository: 'https://github.com/contact411/jaRules',
      installCommand: 'curl -fsSL https://jarule.dev/setup | sh',
      components: {
        dotfiles: 'https://jarule.dev/setup/dotfiles',
        rules: 'https://jarule.dev/setup/rules',
        node: 'https://jarule.dev/setup/node'
      }
    }, null, 2), {
      headers: {
        'Content-Type': 'application/json',
        'Cache-Control': 'public, max-age=300',
        ...corsHeaders
      }
    });
  } catch (error) {
    return new Response(JSON.stringify({
      version: 'unknown',
      error: 'Unable to fetch version info',
      repository: 'https://github.com/contact411/jaRules'
    }), {
      headers: {
        'Content-Type': 'application/json',
        ...corsHeaders
      }
    });
  }
}

/**
 * Handle 404 with style
 */
async function handle404() {
  return new Response(`#!/bin/bash
echo "🤔 Path not found, but that's okay!"
echo "🎯 Try: curl -fsSL https://jarule.dev/setup | sh"
echo "📚 Or visit: https://github.com/contact411/jaRules"
`, {
    status: 404,
    headers: {
      'Content-Type': 'text/plain; charset=utf-8',
    }
  });
}

/**
 * Fetch file from GitHub repository
 */
async function fetchGitHubFile(path) {
  try {
    const response = await fetch(`https://raw.githubusercontent.com/contact411/jaRules/main/${path}`, {
      cf: {
        cacheTtl: 300, // Cache for 5 minutes
        cacheEverything: true,
      }
    });
    
    if (response.ok) {
      return await response.text();
    }
    return null;
  } catch (error) {
    console.error(`Failed to fetch ${path}:`, error);
    return null;
  }
}

/**
 * Generate bootstrap script for when main installer isn't ready
 */
function generateBootstrapScript(mode = 'full') {
  return `#!/bin/bash
echo "🎯 jaRules Bootstrap Installer - ${mode} mode"
echo "⚡ The legendary development environment setup"

# Clone repository
if ! command -v git >/dev/null 2>&1; then
    echo "❌ Git is required but not installed."
    exit 1
fi

echo "📥 Cloning jaRules repository..."
git clone https://github.com/contact411/jaRules.git ~/jarules-temp
cd ~/jarules-temp

# Make scripts executable
chmod +x scripts/*.sh

case "${mode}" in
    "dotfiles-only")
        echo "🔧 Installing dotfiles only..."
        # Run dotfiles setup when available
        echo "⚠️  Dotfiles installer coming soon!"
        ;;
    "rules-only")
        echo "🤖 Installing AI rules only..."
        # Run AI rules setup when available  
        echo "⚠️  AI rules installer coming soon!"
        ;;
    *)
        echo "🚀 Full jaRules installation..."
        if [[ -f "scripts/setup-node.sh" ]]; then
            ./scripts/setup-node.sh
        fi
        ;;
esac

echo "✅ Bootstrap installation completed!"
echo "💡 Full jaRules features coming soon..."

# Cleanup
cd ~ && rm -rf ~/jarules-temp
`;
}