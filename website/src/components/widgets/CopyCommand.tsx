import React, { useState } from 'react'
import { Button } from '../ui/button'
import { cn } from '../../lib/utils'
import { Copy, Check } from 'lucide-react'

interface CopyCommandProps {
  command: string
  label: string
  variant?: 'default' | 'outline' | 'jarule'
  size?: 'default' | 'sm' | 'lg' | 'xl'
  className?: string
}

export default function CopyCommand({ 
  command, 
  label, 
  variant = 'default',
  size = 'default',
  className 
}: CopyCommandProps) {
  const [copied, setCopied] = useState(false)

  const handleCopy = async () => {
    try {
      await navigator.clipboard.writeText(command)
      setCopied(true)
      setTimeout(() => setCopied(false), 2000)
    } catch (error) {
      // Fallback for older browsers
      const textarea = document.createElement('textarea')
      textarea.value = command
      document.body.appendChild(textarea)
      textarea.select()
      document.execCommand('copy')
      document.body.removeChild(textarea)
      setCopied(true)
      setTimeout(() => setCopied(false), 2000)
    }
  }

  return (
    <div className={cn("group relative", className)}>
      <div className="bg-card border border-border rounded-lg p-4 hover:border-primary/50 transition-all duration-200">
        <div className="flex items-center justify-between gap-4">
          <div className="flex-1">
            <div className="text-sm text-muted-foreground mb-1">{label}</div>
            <code className="text-sm md:text-base font-mono text-primary break-all">
              {command}
            </code>
          </div>
          
          <Button
            variant={variant}
            size={size}
            onClick={handleCopy}
            className={cn(
              "shrink-0 transition-all duration-200",
              copied && "bg-green-600 hover:bg-green-700"
            )}
          >
            {copied ? (
              <>
                <Check className="w-4 h-4 mr-2" />
                Copied!
              </>
            ) : (
              <>
                <Copy className="w-4 h-4 mr-2" />
                Copy
              </>
            )}
          </Button>
        </div>
      </div>
      
      {/* Hover effect */}
      <div className="absolute inset-0 bg-gradient-to-r from-primary/5 to-accent/5 rounded-lg opacity-0 group-hover:opacity-100 transition-opacity duration-200 pointer-events-none" />
    </div>
  )
}