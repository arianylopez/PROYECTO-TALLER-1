let globalProducts = [];

document.addEventListener('DOMContentLoaded', async () => {
    // Estado de carga inicial
    document.getElementById('catalog-container').innerHTML = '<p style="text-align:center; width:100%; grid-column: 1 / -1;">Cargando catálogo...</p>';

    // Configurar eventos de botones fijos
    document.getElementById('btn-toggle-cart').addEventListener('click', UI.toggleCart);
    document.getElementById('btn-close-cart').addEventListener('click', UI.toggleCart);

    // Obtener datos reales de Supabase
    globalProducts = await API.getProducts();
    
    // Dibujar interfaz
    UI.renderProducts(globalProducts);
});