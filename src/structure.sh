#!/bin/bash

# Función para verificar si un directorio o archivo existe
check_exists() {
    if [ -e "$1" ]; then
        echo "⚠️  Advertencia: '$1' ya existe"
        return 0
    fi
    return 1
}

# Función para hacer backup de un archivo o directorio
make_backup() {
    local backup_name="$1_backup_$(date +%Y%m%d_%H%M%S)"
    if [ -e "$1" ]; then
        echo "📦 Creando backup: $backup_name"
        mv "$1" "$backup_name"
    fi
}

# Verificar si algún directorio o archivo importante ya existe
existing_items=()
for item in "components" "services" "css" "index.html" "app.js" "productos.json"; do
    if check_exists "$item"; then
        existing_items+=("$item")
    fi
done

# Si hay elementos existentes, preguntar qué hacer
if [ ${#existing_items[@]} -gt 0 ]; then
    echo "❗ Se encontraron elementos existentes:"
    printf '%s\n' "${existing_items[@]}"
    echo
    echo "¿Qué deseas hacer?"
    echo "1) Crear backup y continuar"
    echo "2) Sobrescribir sin backup"
    echo "3) Cancelar operación"
    read -p "Selecciona una opción (1-3): " choice

    case $choice in
        1)
            echo "🔄 Creando backups..."
            for item in "${existing_items[@]}"; do
                make_backup "$item"
            done
            ;;
        2)
            echo "⚠️  Sobrescribiendo archivos existentes..."
            ;;
        3)
            echo "❌ Operación cancelada"
            exit 1
            ;;
        *)
            echo "❌ Opción inválida, operación cancelada"
            exit 1
            ;;
    esac
fi

echo "🚀 Iniciando creación de estructura..."

# Crear directorios principales
mkdir -p components services css

# Crear archivo HTML principal
cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Aplicación</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <app-root></app-root>
    <script type="module" src="app.js"></script>
</body>
</html>
EOF

# Crear archivo JavaScript principal
cat > app.js << 'EOF'
import './components/app-root.js';
import './components/app-home.js';
import './components/product-details.js';
import './components/not-found.js';
EOF

# Crear archivos de componentes
cat > components/app-root.js << 'EOF'
// Componente raíz de la aplicación
EOF

cat > components/app-home.js << 'EOF'
// Componente de página principal
EOF

cat > components/product-details.js << 'EOF'
// Componente de detalles de producto
EOF

cat > components/not-found.js << 'EOF'
// Componente para página 404
EOF

# Crear archivos de servicios
cat > services/product-service.js << 'EOF'
// Servicio para gestionar productos
EOF

cat > services/cart-service.js << 'EOF'
// Servicio para gestionar el carrito
EOF

# Crear archivo CSS
cat > css/styles.css << 'EOF'
/* Estilos principales de la aplicación */
EOF

# Crear archivo JSON de productos
cat > productos.json << 'EOF'
{
  "productos": [
    {
      "id": 1,
      "nombre": "Producto 1",
      "precio": 100
    }
  ]
}
EOF

echo "✅ ¡Estructura de directorios y archivos creada exitosamente!"
echo
echo "📁 Estructura del proyecto:"
tree .