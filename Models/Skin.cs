using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace routing.Models;

[Table("skin")]
public class Skin
{
    [Key]
    [Column("id")]
    public int Id { get; set; }
    
    [Required]
    [Column("name")]
    public string Name { get; set; }
    
    [Required]
    [Column("author")]
    public string Author { get; set; }
    
    [Required]
    [Column("assets_path")]
    public string AssetsPath { get; set; }
    
    [Required]
    [Column("size")]
    public float Size { get; set; }
}