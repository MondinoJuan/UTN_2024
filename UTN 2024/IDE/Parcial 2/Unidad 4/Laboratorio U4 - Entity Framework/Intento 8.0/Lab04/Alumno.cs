using System;
using System.ComponentModel.DataAnnotations;

public class Alumno
{
    public Alumno()
    {
    }

    [Key] 
    public int Id { get; set; }

    [Required] 
    [StringLength(50)]
    public string Nombre { get; set; }

    [Required]
    [StringLength(50)]
    public string Apellido { get; set; }

    [Required] 
    public int Legajo { get; set; }

    [Required]
    [StringLength(100)]
    public string Direccion { get; set; }
}
