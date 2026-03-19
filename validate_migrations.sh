# #!/bin/bash

# pattern="^V([0-9]+)\.([0-9]+)\.([0-9]+)__(.+)\.sql$"

# files=$(git diff --cached --name-only --diff-filter=ACM | grep migrations)

# [ -z "$files" ] && exit 0

# invalid=0

# # 🔹 pega última versão commitada (main)
# last_version=$(git ls-files migrations \
#   | sed -E 's/.*V([0-9]+\.[0-9]+\.[0-9]+)__.*$/\1/' \
#   | sort -V \
#   | tail -n1)

# echo "📌 Última versão encontrada: V$last_version"

# # transforma versão em número comparável
# version_to_number() {
#   IFS='.' read -r major minor patch <<< "$1"
#   echo $((major * 1000000 + minor * 1000 + patch))
# }

# last_version_num=$(version_to_number "$last_version")

# for file in $files; do
#   filename=$(basename "$file")

#   echo ""
#   echo "🔍 Validando: $filename"

#   # 🔹 valida __
#   if [[ "$filename" != *"__"* ]]; then
#     suggestion=$(echo "$filename" | sed -E 's/_(.+)/__\1/')
#     echo "❌ Falta '__'"
#     echo "💡 Sugestão: $suggestion"
#     invalid=1
#     continue
#   fi

#   # 🔹 valida regex completa
#   if [[ ! $filename =~ $pattern ]]; then
#     echo "❌ Nome fora do padrão"
#     echo "Formato esperado: V1.49.0__descricao.sql"
#     invalid=1
#     continue
#   fi

#   # 🔹 extrai versão
#   version="${BASH_REMATCH[1]}.${BASH_REMATCH[2]}.${BASH_REMATCH[3]}"
#   version_num=$(version_to_number "$version")

#   # 🔹 valida se versão é maior
#   if [ "$version_num" -le "$last_version_num" ]; then
#     echo "❌ Versão inválida: V$version"
#     echo "💡 Deve ser maior que: V$last_version"

#     # sugestão automática
#     IFS='.' read -r major minor patch <<< "$last_version"

#     next_patch="V$major.$minor.$((patch + 1))"
#     next_minor="V$major.$((minor + 1)).0"

#     echo "💡 Sugestões válidas:"
#     echo "   → $next_patch"
#     echo "   → $next_minor"

#     invalid=1
#     continue
#   fi

#   echo "✅ OK"
# done

# if [ $invalid -eq 1 ]; then
#   echo ""
#   echo "🚫 Commit bloqueado."
#   exit 1
# fi

# echo ""
# echo "✅ Todas as migrations estão válidas"