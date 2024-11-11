namespace Inmobiliaria.Domain
{
    // Estas validaciones podrían implementarse como un método de extensión o también dentro de la misma entidad.
    // También se podría mejorar la implementación para que "acumule" todas los casos incorrectos y los informe en una única vez.
    internal class PropiedadValidation
    {

        public static bool IsValid(Propiedad propiedad)
        {
            
            if (propiedad == null)
            {
                throw new Exception("Los datos de propiedad son requeridos");
            }

            if (propiedad.CantidadHabitaciones <= 0)
            {
                throw new Exception("El campo Cantidad Habitaciones debe ser mayor a 0.");
            }
            if (propiedad.Precio <= 0)
            {
                throw new Exception("El campo Precio debe ser mayor a 0.");
            }
            if (String.IsNullOrEmpty(propiedad.Titulo))
            {
                throw new Exception("El campo Titulo es requerido.");
            }

            if (String.IsNullOrEmpty(propiedad.Descripcion) ||
                propiedad.Descripcion.Length > 50)
            {
                throw new Exception("El campo Descripcion es requerido y tiene que tener menos de 50 caracteres.");
            }
            // Otras valiciones.

            // Si llega hasta acá es porque no falló ninguna validación.
            return true;
           
        }
    }
}
