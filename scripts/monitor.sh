#!/bin/bash

while true; do
    clear
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║          Monitoring DevOps - $(date '+%H:%M:%S')                    ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo ""
    
    echo "📦 Containers Docker:"
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | head -10
    echo ""
    
    echo "💾 Ressources:"
    echo "  CPU: $(top -bn1 | grep "Cpu(s)" | awk '{print $2}')%"
    echo "  RAM: $(free -h | awk '/Mem:/ {print $3 "/" $2}')"
    echo "  Disk: $(df -h / | awk 'NR==2 {print $3 "/" $2 " (" $5 ")"}')"
    echo ""
    
    echo "Rafraîchissement dans 5 secondes... (Ctrl+C pour arrêter)"
    sleep 5
done
