# Private ocumentation portal

## How to run locally


1. Open terminal.
2. Clone the repo to your computer by running the following command:  
```bash
git clone git@github.com:dmitriyrotaenko/documentation-portal.git
```
3. Change directory to the cloned repo:  
```bash
cd documentation-portal
```
4. Install dependencies by running the following command:
```bash
gem install bundler && bundle install && npm install
```
5. Run migrations via the following command:
```bash
rails db:migrate
```
6. Launch the app via foreman:
```bash
bin/dev
```

## How to run in Docker



