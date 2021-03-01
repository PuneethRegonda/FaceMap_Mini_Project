
const jwt = require('jsonwebtoken');

module.exports = function(req, res, next) {
    const token = req.header('auth-token');
    if (!token) {
        return res.status(401).json({ status: 'failed', message: 'Access Denied' });
    }

    try {
        const verified = jwt.verify(token, process.env.SECRET_TOKEN);
        if (verified.email == null) {
            res.status(403).json({ status: 'failed', message: 'Invalid token' });
            return;
        }
        console.log("verifed");
        req.user = verified;
        console.log(req);
        next();
    } catch (err) {
        if (err.name.includes('TokenExpiredError')) {
            res.status(401).json({ status: 'failed', message: 'Access-Token Expired' });
            return;
        }
        console.log(err);
        res.status(500).json({ status: 'failed', message: 'Internal server error' });
    }
}