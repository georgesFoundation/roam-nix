# Contributing to Roam Nix Package

Thank you for your interest in contributing! This guide will help you get started.

## 🚀 Quick Start

1. **Fork & Clone**
   ```bash
   git clone https://github.com/georgesFoundation/Roam-nix.git
   cd Roam-nix
   ```

2. **Install Dependencies**
   ```bash
   nix develop
   ```

3. **Make Changes**
   - Edit `default.nix` for package changes
   - Update `README.md` for documentation
   - Add tests to `test.sh`

4. **Test Your Changes**
   ```bash
   ./test.sh
   ```

## 🧪 Development Workflow

### Building the Package

```bash
# Build the package
nix build .#roam

# Clean build
rm -f result

# Enter development shell
nix develop
```

### Testing

```bash
# Run comprehensive tests
./test.sh

# Test specific functionality
./result/bin/roam --version
```

### Code Style

- Follow Nix best practices
- Use meaningful variable names
- Keep dependencies organized alphabetically
- Document complex changes in comments

## 📦 Package Structure

```
Roam-nix/
├── default.nix         # Main package definition
├── flake.nix           # Modern Nix flake interface
├── shell.nix           # Traditional Nix compatibility
├── test.sh             # Comprehensive test suite
├── README.md           # User documentation
├── LICENSE             # MIT license
└── examples/           # Usage examples
    ├── configuration.nix
    └── home-manager.nix
```

## 🔄 Updating the Package

When a new Roam version is released:

1. **Update Version**
   ```nix
   version = "NEW.VERSION.HERE";
   ```

2. **Update Hash**
   ```bash
   nix-prefetch-url https://download.ro.am/Roam/8a86d88cfc9da3551063102e9a4e2a83/latest/linux/x64/Roam.deb
   ```

3. **Update Dependencies**
   - Check if new dependencies are required
   - Test with `./test.sh`

4. **Update Documentation**
   - Update version in README.md
   - Add changelog entry

## 🐛 Bug Reports

When reporting bugs, please include:

- **NixOS/Nix version**: `nix --version`
- **System architecture**: `uname -m`
- **Error message**: Full error output
- **Steps to reproduce**: Clear reproduction steps
- **Expected behavior**: What should happen

## 💡 Feature Requests

We welcome feature requests! Please:

1. Check existing issues first
2. Describe the use case clearly
3. Consider implementation complexity
4. Suggest API changes if applicable

## 📝 Submitting Changes

1. **Create Feature Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make Changes**
   - Follow the existing code style
   - Add tests for new features
   - Update documentation

3. **Test Thoroughly**
   ```bash
   ./test.sh
   ```

4. **Commit Changes**
   ```bash
   git add .
   git commit -m "feat: add your feature description"
   ```

5. **Push & Create PR**
   ```bash
   git push origin feature/your-feature-name
   ```

## 🏷️ Commit Message Format

We use conventional commits:

- `feat:` for new features
- `fix:` for bug fixes
- `docs:` for documentation changes
- `style:` for code style changes
- `refactor:` for code refactoring
- `test:` for adding tests
- `chore:` for maintenance tasks

Examples:
```
feat: add support for new Roam version
fix: resolve library path issues
docs: update installation instructions
```

## 🧪 Testing Guidelines

### Before Submitting

- [ ] Package builds successfully: `nix build .#roam`
- [ ] All tests pass: `./test.sh`
- [ ] Binary starts without errors
- [ ] Documentation is updated
- [ ] No linting errors

### Test Categories

1. **Build Tests**: Package builds and installs
2. **Runtime Tests**: Binary starts and runs
3. **Integration Tests**: Desktop files work correctly
4. **Dependency Tests**: All libraries are found

## 📚 Resources

- [Nix Packaging Guide](https://nixos.org/manual/nixpkgs/stable/#chap-packaging)
- [Nix Flakes](https://nixos.wiki/wiki/Flakes)
- [AUR Packaging Guidelines](https://wiki.archlinux.org/title/Arch_package_guidelines)
- [Electron Apps on Nix](https://nixos.wiki/wiki/Electron)

## 🤝 Community

- Be respectful and constructive
- Help others with their issues
- Share knowledge and experiences
- Follow the [Code of Conduct](CODE_OF_CONDUCT.md)

## 📧 Getting Help

- Create an issue for questions
- Join our discussions
- Check existing documentation
- Search past issues

Thank you for contributing to Roam Nix Package! 🎉
