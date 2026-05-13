class RolePermissions {

  static bool isSuperAdmin(String role) => role == 'superadmin';
  static bool isAdminPais(String role) => role == 'admin_pais';
  static bool isEditor(String role) => role == 'editor';

  // 👁️ VER CONTENIDO (todos pueden ver)
  static bool canView(String role) => true;

  // ✏️ CREAR (NO editor)
  static bool canCreate(String role) =>
      role == 'superadmin' || role == 'admin_pais';

  // ✏️ EDITAR (NO editor)
  static bool canEdit(String role) =>
      role == 'superadmin' || role == 'admin_pais';

  // 🗑️ ELIMINAR (solo superadmin)
  static bool canDelete(String role) =>
      role == 'superadmin';

  // 🌍 ACCESO A MÓDULOS
  static bool canAccess(String role, String route) {
    if (role == 'superadmin') return true;

    if (role == 'admin_pais') return true;

    if (role == 'editor') {
      return route == '/noticias' || route == '/portales';
    }

    return false;
  }
}