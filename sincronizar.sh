echo " eliminando carrpeta  vieja "
rm -rf lua # eliminar el enlace simbólico
cp -r ~/.config/nvim/lua ./lua
git add .
git commit -m "actualizacion"
git push origin main
