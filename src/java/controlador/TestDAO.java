/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import modelo.Usuario;

public class TestDAO {
    public static void main(String[] args) {
        UsuarioDAOImpl dao = new UsuarioDAOImpl();
        
        Usuario u = new Usuario();
        u.setNombre("Test");
        u.setApellido("DAO");
        u.setEmail("dao@test.com");
        u.setUsuario("testdao");
        u.setClave("123");
        u.setPerfil(2);
        
        System.out.println("Resultado insert: " + dao.agregar(u));
    }
}