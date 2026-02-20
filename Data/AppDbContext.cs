using Microsoft.EntityFrameworkCore;
using routing.Models;

namespace routing.Data;

public class AppDbContext(DbContextOptions<AppDbContext> options) : DbContext(options)
{
    public DbSet<Skin> Skins { get; set; }
}