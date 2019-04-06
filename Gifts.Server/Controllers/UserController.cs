using Gifts.Shared;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

namespace Gifts.Server.Controllers
{
    [Route("api/[controller]")]
    public class UserController : Controller
    {
        [HttpGet("[action]")]
        public IEnumerable<User> GetAll()
        {
            return new List<User>() {
                new User()
                {
                    FirstName = "David",
                    LastName = "Rosko",
                    Id = 23
                },
                 new User()
                {
                    FirstName = "David",
                    LastName = "Rosko",
                    Id = 23
                },
                  new User()
                {
                    FirstName = "David",
                    LastName = "Rosko",
                    Id = 23
                },
                   new User()
                {
                    FirstName = "David",
                    LastName = "Rosko",
                    Id = 23
                }
            };
        }
    }
}
