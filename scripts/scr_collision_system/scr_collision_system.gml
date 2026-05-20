function CollisionSystem(_layer_name, _left, _top, _right, _bottom) constructor {

    // Tenta obter o tilemap da layer; pode não existir em algumas rooms
    var _layer_id = layer_get_id(_layer_name);
    if (_layer_id == -1) {
        tilemap = -1;
    } else {
        tilemap = layer_tilemap_get_id(_layer_id);
        if (tilemap == -1) {
            // fallback quando não há tilemap na layer
            tilemap = -1;
        }
    }
    left   = _left;
    top    = _top;
    right  = _right;
    bottom = _bottom;

    /// @function   resolve_x(x, y, vx)
    static resolve_x = function(_x, _y, _vx) {
        // Se não existe tilemap válido, não tenta checar tiles
        if (tilemap == -1) return _vx;
        if (tilemap_get_at_pixel(tilemap, _x + _vx + right, _y - top)        > 0 ||
            tilemap_get_at_pixel(tilemap, _x + _vx + right, _y + bottom)     > 0 ||
            tilemap_get_at_pixel(tilemap, _x + _vx + right, _y - top/2)      > 0 ||
            tilemap_get_at_pixel(tilemap, _x + _vx + right, _y + bottom/2)   > 0 ||
            tilemap_get_at_pixel(tilemap, _x + _vx - left,  _y - top)        > 0 ||
            tilemap_get_at_pixel(tilemap, _x + _vx - left,  _y + bottom)     > 0 ||
            tilemap_get_at_pixel(tilemap, _x + _vx - left,  _y - top/2)      > 0 ||
            tilemap_get_at_pixel(tilemap, _x + _vx - left,  _y + bottom/2)   > 0) {
            return 0;
        }
        return _vx;
    };

    /// @function   resolve_y(x, y, vy)
    static resolve_y = function(_x, _y, _vy) {
        // Se não existe tilemap válido, não tenta checar tiles
        if (tilemap == -1) return _vy;
        if (tilemap_get_at_pixel(tilemap, _x + right,   _y + _vy - top)      > 0 ||
            tilemap_get_at_pixel(tilemap, _x + right,   _y + _vy + bottom)   > 0 ||
            tilemap_get_at_pixel(tilemap, _x - left,    _y + _vy - top)      > 0 ||
            tilemap_get_at_pixel(tilemap, _x - left,    _y + _vy + bottom)   > 0 ||
            tilemap_get_at_pixel(tilemap, _x + right/2, _y + _vy - top)      > 0 ||
            tilemap_get_at_pixel(tilemap, _x + right/2, _y + _vy + bottom)   > 0 ||
            tilemap_get_at_pixel(tilemap, _x - left/2,  _y + _vy - top)      > 0 ||
            tilemap_get_at_pixel(tilemap, _x - left/2,  _y + _vy + bottom)   > 0) {
            return 0;
        }
        return _vy;
    };

}