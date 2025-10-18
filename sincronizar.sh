echo " eliminando carrpeta  vieja "
rm -rf lua # eliminar el enlace simbólico
cp -r ~/.config/nvim/lua ./lua
echo "haciendo commit"
git add .
git commit -m "actualizacion"
git push origin main
